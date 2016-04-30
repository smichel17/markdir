#!/bin/bash

process_Dir() {
    OutFile="${OutDir}${DirName}${OUTEXT}"
    # echo -e "$DirName" >> "$OutFile"
    echo "$DirName >> $OutFile"
    process_subdirs
    process_FILES
}

    # echo -e "# ${title}\n\n" >> "${1}"/README.md
    # cat "${file}" >> "${1}"/"${file##*/}"

process_File() {
    echo "$File >> $OutFile"
    echo "FileName: $FileName"

    # printf "## ${1}\n\n" >> "${OutFile}"
    # cat "${2}" >> "${3}"
    # printf "\n" >> "${3}"
}
