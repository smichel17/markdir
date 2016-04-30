#!/bin/bash

process_Dir() {
    OutFile="${OutDir}${Dir%${MDIREXT}}${OUTEXT}"
    local title
    title="${1%.mdir/}"     # Trim the extension
    title="${title##*/}"    # Trim the prefixed path
    echo -e "$title" >> "$OutFile"

    echo "$title >> $OutFile"
    process_subdirectories "$1"
    process_FILES "${1}"
}

    # echo -e "# ${title}\n\n" >> "${1}"/README.md
    # cat "${file}" >> "${1}"/"${file##*/}"

process_File() {
    echo "$OutFile <-- $1"
    local title
    title="${1##*/}"
    echo "$title"

    # printf "## ${1}\n\n" >> "${OutFile}"
    # cat "${2}" >> "${3}"
    # printf "\n" >> "${3}"
}
