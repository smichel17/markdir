#!/bin/bash

# markdir.sh v0.9.1

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

usage() {
    echo "Usage: ${0} [OPTION...] DIRECTORY..."
    echo ""
    echo "  -h, --help   Print this message"
    echo "  -f           Ignore extension. Treat all files and directories as mdir"
    exit 1
}

main() {
    DIRS=()
    FILTERS=()
    ARGS=() # Currently unused unless a filter sets it
    parse_args "$@"
    for Filter in "${FILTERS[@]}"; do
        if [[ -e "$Filter" ]]; then (
            source "$Filter"
            process_DIRS "${ARGS[@]}" )
        else
            echo "Filter $Filter not found"
        fi
    done
}

parse_args() {
    # Defaults
    OUTDIR="${PWD%/}"
    OUTEXT=".md"
    MDIREXT=".mdir"
    FILTERS+=( "./clean.sh" )

    # Parse
    while [ "$#" -ne 0 ]; do
        case $1 in
            -o|--out|--output|--output_folder|--output_dir|--output_directory)
                local tmp
                case "$2" in 
                    .|./)
                        OUTDIR=( "${PWD%/}" ) ;;
                    ~|~/)
                        OUTDIR=( "${HOME%/}" );;
                    *)
                        OUTDIR="${2}" ;;
                esac
                shift 2 ;;
            -x|--execute)
                FILTERS+=( "${2}" )
                shift 2 ;;
            -h|--help)
                usage ;;
            -f)
                MDIREXT=""
                shift ;;
            # -+(f|r|s))
                # echo "ERROR: ${2} is not supported... yet! (It's planned) "
                # shift ;;
            ./|.)
                DIRS+=( "${PWD%/}" ); shift ;;
            ./*)
                DIRS+=( "${PWD%/}${1#.}" ); shift ;;
            ~|~/)
                DIRS+=( "${HOME%/}" ); shift;;
            *)
                DIRS+=( "${1%/}" ); shift ;;
        esac
    done

    # More defaults (currently just checks)
    [[ ${#DIRS[@]} -eq 0 ]] && { echo "ERROR: No source folder."; usage; }
    [[ ${#DIRS[@]} -ge 2 ]] && { echo "ERROR: Too many source folders."; usage; }
    [[ ${#FILTERS[@]} -eq 1 ]] && { echo "ERROR: No filter."; usage; }
}

process_subdirs() { (
    shopt -s nullglob # Stops infinite loops if there are no subdirs
    DIRS=( "${Dir%/}"/*/ )
    DIRS=( "${DIRS[@]%/}" )
    process_DIRS "$@"
) }

process_DIRS() {
    for Dir in "${DIRS[@]%/}"; do
        FullDirName="${Dir##*/}"
        DirName="${FullDirName%${MDIREXT}}"
        DirExt="${FullDirName#${DirName}}" # Needed to distinguish "x.mdir" from "mdir"
        if [[ ! -e "${Dir}" ]]; then
            echo "ERROR: ${Dir} not found"
        elif [[ ! -d "${Dir}" ]]; then
            echo "${Dir}: Not a directory"
        elif [[ "${DirExt}" == "${MDIREXT}" ]]; then
            ( process_Dir "$@" )
        else
            process_subdirs "$@"
        fi
    done
}

process_Dir() {
    process_subdirs
    process_files
}

process_files() { (
    shopt -s nullglob # If there's no matches, don't return any
    FILES=( "${Dir%/}"/* )
    process_FILES "$@"
) }

process_FILES() {
    for File in "${FILES[@]}"; do
        if [ -f "$File" ]; then
            FullFileName="${File##*/}"
            FileName="${FullFileName%.*}"
            FileExt="${FullFileName#${FileName}}" # Tell "x.mdir" from "mdir"
            ( process_File "$@" )
        fi
    done
}

process_File() {
    echo "FILE: $File"
}

main "$@"
