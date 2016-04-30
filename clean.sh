DIRS=()
DIRS+="${OUTDIR}"

process_DIRS() {
    for Dir in "${DIRS[@]}"; do
        DirName="${Dir%${MDIREXT}}"
        DirExt="${Dir#${DirName}}" # Distinguish "name.mdir" from "mdir"
        if [[ ! -e "${Dir}" ]]; then
            echo "${Dir}: Directory not found"
        elif [[ ! -d "${Dir}" ]]; then
            echo "${Dir}: Not a directory"
        elif [[ "${DirExt}" == "${MDIREXT}" ]]; then
            local tmp
            # Omit mdirs
        else
            ( process_Dir )
        fi
    done
}

# Really simple default
process_Dir() {
    process_subdirs
    process_FILES
}

# Default is clean
process_File() {
    if [ "$FileExt" == "$OUTEXT" ]; then
        rm "$File"
    fi
}

