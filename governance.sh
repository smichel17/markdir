ARGS=( "$OUTDIR" )

process_Dir() {
    [[ -e "${1}" ]] || mkdir -p "${1}"
    OutFile="${1}/${DirName}${OUTEXT}"
    echo "---" > "$OutFile"
    echo "title: $DirName" >> "$OutFile"
    echo -e "..." >> "$OutFile"
    process_files
    process_subdirs "${1}/${DirName}" "${2}/${DirName}"
    cat "${OutFile}_" >> "$OutFile"
    if [[ "$1" != "$OUTDIR" ]]; then
        echo -e "\n\n# [$DirName](${2}/${DirName})\n" >> "${1}${OUTEXT}_"
        cat "${OutFile}_" >> "${1}${OUTEXT}_"
    fi
    rm "${OutFile}_"
}

process_File() {
    echo -e "\n## $FileName\n" >> "${OutFile}_"
    cat "$File" >> "${OutFile}_"
}
