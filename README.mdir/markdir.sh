#!/bin/bash

# markdir.sh v0.9.0

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

# Syntax Guide: localVariableName GlobalVariableName function_name

usage() {
    echo "Usage: ${0} [OPTION...] DIRECTORY..."
    echo ""
    echo "  -h, --help   Print this message"
    echo "  -f           Ignore extension. Treat all files and directories as mdir"
    exit 1
}

main() {
    set_defaults
    parse_args "$@"
    for dir in "${mdirs[@]%/}"; do
        clean_dir $dir
        for filter in "${filters[@]}"; do
            ( source "$filter"; process_dir "$dir" ) # process_dir provided by filter
        done
    done
}

set_defaults() {
    OutDir="${PWD%/}/"
    MdirExt=".mdir"
    Mdirs=()
    Filters=()
}

parse_args() {
    while [ "$#" -ne 0 ]; do
        case $1 in
            -h|--help)
                    usage ;;
            -o|--out|--output|--output_folder|--output_dir|--output_directory)
                    OutDir="${2}"
                    shift; shift ;;
            -x|--execute)
                    Filters+="${2}"
                    shift; shift ;;
            -f)
                    MdirExt="";
                    shift ;;
            -+(f|r|s))
                    echo "ERROR: ${1} is not supported... yet! Hang in there, it's planned. "
                    shift ;;
            .|./)
                    add_mdir "${PWD}"; shift ;;
            *)
                    add_mdir "${1}"; shift ;;
        esac
    done

    [[ ${#mdirs[@]} -eq 0 ]] && { echo "ERROR: No source folder selected."; usage; }
    [[ ${#mdirs[@]} -ge 2 ]] && { echo "ERROR: Too many source folders."; usage; }
    [[ ${#filters[@]} -eq 0 ]] && { echo "ERROR: No filter selected."; usage; }
}

add_mdir() {
    validate_dir "${1}"
    case $? in  # return value
        0)
            Mdirs+="${1}" ;;
        1)
            echo "${rootdir}: Directory not found" ;;
        2)
            echo "${rootdir}: Not a directory" ;;
        3)
            echo "${rootdir}: not a .mdir. Use -f to ignore directory extensions." ;;
        *)
            echo "${rootdir}: Bad file name, for an unknown reason"
    esac
}

validate_dir() {
    [[ -e "${1}" ]] || return 1
    [[ -d "${1}" ]] || return 2
    
    # Find the extension in a way that can distinguish "name.mdir" from "mdir"
    dirExt="${1%${MdirExt}}"     # get dirname sans extension
    dirExt="${1#${dirExt}}"     # get extension sans dirname
     
    [[ "${dirExt}" == "${Ext}" ]] && return 0 || return 3
    return -1
}

clean_dir() {
    find -name *${Ext} -exec rm {} +
}

process_subdirs() {
    for dir in ( "${1%/}/"*"${MdirExt}"/ ); do
        ( process_dir "${dir}" )
    done
}

process_files() {
    for file in ( "${1%/}"/* ); do
        if [ -f $file ]; then
            ( OutFile="${OutDir}/${file}.md"; process_file "${file}"
        fi
    done
}

main "$@"
