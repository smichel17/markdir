ARGS=( "$OUTDIR" )

process_Dir() {
    # echo "DIR"
    [[ -e "${1}" ]] || mkdir -p "${1}"
    OutFile="${1}/${DirName}${OUTEXT}"
    echo "# $DirName" >> "$OutFile"
    # echo "# $DirName >> $OutFile"
    process_subdirs "${1}/${DirName}"
    process_files # "${1}"
}

process_File() {
    # echo -e "\n## $FileName\n >> $OutFile"
    echo -e "\n## $FileName\n" >> "$OutFile"
    # echo "cat $File >> $OutFile"
    cat "$File" >> "$OutFile"
}
