DIRS=()
DIRS+="${OUTDIR}"

process_DIRS() {
    for Dir in "${DIRS[@]}"; do
        FullDirName="${Dir##*/}"
        DirName="${FullDirName%${MDIREXT}}"
        DirExt="${FullDirName#${DirName}}" # Needed to distinguish "x.mdir" from "mdir"
        if [[ ! -e "${Dir}" ]]; then
            echo "${Dir}: Directory not found"
        elif [[ ! -d "${Dir}" ]]; then
            echo "${Dir}: Not a directory"
        elif [[ "${DirExt}" != "${MDIREXT}" ]]; then
            ( process_Dir )
        fi
    done
}

# Really simple default
process_Dir() {
    process_subdirs
    process_files
}

# Default is clean
process_File() {
    if [ "$FileExt" == "$OUTEXT" ]; then
        # echo "rm $File"
        rm "$File"
    fi
}

