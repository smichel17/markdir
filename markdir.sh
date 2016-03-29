#!/bin/bash

# markdir.sh #

# Copyright 2016 Stephen Michel

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

function add_mdir() {
    printf "## ${1}\n\n" >> "${3}"
    cat "${2}" >> "${3}"
    printf "\n" >> "${3}"
}

function build_directory() {
    # spring cleaning
    rm "${1}"/*.md
    local title
    title="${1%${ext}}"
    title="${title##*/}"

    # Init README.md
    printf "# ${title}\n\n" >> "${1}"/README.md

    # build from mdir files
    local filename
    while IFS= read -r -d '' file; do
        add_mdir "${title}" "${file}" "${file%.mdir}".md
        filename="${file##*/}"
        add_mdir "${filename%.mdir}" "${file}" "${1}"/README.md
    done < <(find "${1}"/*.mdir -maxdepth 0 -type f -print0)

    # build subdir, then add its files
    local dir
    while IFS= read -r -d '' dir; do
        build_directory "${dir}"
        for file in "${dir}"/*.md; do
            cat "${file}" >> "${1}"/"${file##*/}"
        done
    done < <(find "${1}"/*"${ext}" -maxdepth 0 -type d -print0)
}

function usage() {
    echo "Usage: ${0} [OPTION...] DIRECTORY..."
    echo ""
    echo "  -h, --help   Print this message"
    echo "  -f           Process all directories regardless of extension"
    exit 1
}

# Defaults
ext=".mdir"
dirlist=()

# Parse Args
while [ "$#" -ne 0 ]; do
    case $1 in
        -f)
            ext=""; shift ;;
        -h|--help)
            usage ;;
        .|./)
            dirlist+=(${PWD}); shift ;;
        *)
            dirlist+=("${1}"); shift ;;
    esac
done

# No directory provided, so use current one
if [ ${#dirlist[@]} -eq 0 ]; then
    dirlist+=${PWD}
fi

# Simple sanitization, then parse!
for rootdir in "${dirlist[@]}"; do
    rootdir="${rootdir%/}";
    # Get the true dir extension. Stops dir named "mdir" from screwing you
    dirext="${rootdir%${ext}}"; dirext="${rootdir#${dirext}}"
    if ! [ -e "${rootdir}" ]; then
        echo "${rootdir}: Directory not found" >&2
    elif ! [ -d "${rootdir}" ]; then
        echo "${rootdir}: Not a directory" >&3
    elif [ "${dirext}" == "${ext}" ]; then
        build_directory "${rootdir}"
    else
        echo "${rootdir}: not a .mdir. Use -f to ignore directory extensions."
    fi
done
