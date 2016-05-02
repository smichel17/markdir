#!/bin/bash

# markdir.sh v0.9.3

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
    for Filter in "${FILTERS[@]}"; do (
        source "$Filter" \
            && process_DIRS "${ARGS[@]}" \
            || echo "Filter $Filter not found"
    ) done
}

parse_args() {
    # Defaults
    OUTDIR="${PWD%/}"
    OUTEXT=".md"
    MDIREXT=".mdir"
    SRCEXT=".md"

    # Parse
    while [ "$#" -ne 0 ]; do
        case $1 in
            -e|--extension)
                OUTEXT="$2"
                shift ;;
            -x|--execute)
                FILTERS+=( "${2}" )
                shift ;;
            -c|--clean)
                FILTERS+=( "clean.sh" ) ;;
            -l|--local)
                FILTERS[1]="./clean.sh" ;;
            -h|--help)
                usage ;;
            -f)
                MDIREXT="" ;;
            # -+(f|r|s))
                # echo "ERROR: ${2} is not supported... yet! (It's planned) "
                # shift ;;
            *.sh)
                FILTERS+=( "${1}" ) ;;
            .|./)
                DIRS+=( "${PWD%%/}" ) ;;
            ./*)
                DIRS+=( "${PWD%%/}${1#.}" ) ;;
            ~|~/)
                DIRS+=( "${HOME%%/}" ) ;;
            *)
                DIRS+=( "${1%%/}" ) ;;
        esac
        shift
    done

    OUTDIR=( ${DIRS[-1]} )
    unset DIRS[-1]

    # More defaults (currently just checks)
    [[ ${#DIRS[@]} -eq 0 ]] && { echo "ERROR: No source folder."; usage; }
    [[ ${#FILTERS[@]} -eq 0 ]] && { echo "ERROR: No filter."; usage; }
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
    FILES=()
    tmp=( "${Dir%/}"/* )
    for f in "${tmp[@]}"; do
        if [ -f "$f" ]; then
            FILES+=( "$f" )
        fi
    done
    process_FILES "$@"
) }

process_FILES() {
    for File in "${FILES[@]}"; do
        FilePath="${File%/*}"
        FullFileName="${File##*/}"
        FileName="${FullFileName%.*}"
        FileExt="${FullFileName#${FileName}}" # Tell "x.mdir" from "mdir"
        if [[ "$FileExt" == "$SRCEXT" ]]; then
            ( process_File "$@" )
        fi
    done
}

process_File() {
    echo "FILE: $File"
}

main "$@"
