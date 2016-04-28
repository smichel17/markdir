process_directory(){
    printf "# ${title}\n\n" >> "${1}"/README.md
    cat "${file}" >> "${1}"/"${file##*/}"
}

process_file() {
}
