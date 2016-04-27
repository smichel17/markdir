#!/bin/bash

# Not ready for primetime yet


process_directory(){
    process_sub





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

process_file() {
    printf "## ${1}\n\n" >> "${3}"
    cat "${2}" >> "${3}"
    printf "\n" >> "${3}"
}
