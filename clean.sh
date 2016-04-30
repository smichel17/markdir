DIRS=()
DIRS+="${OUTDIR}"

process_DIRS() {
    echo "process_DIRS: ${DIRS[@]}"
    for Dir in "${DIRS[@]}"; do
        DirName="${Dir%${MDIREXT}}"
        # Find the extension in a way that can distinguish "name.mdir" from "mdir"
        DirExt="${Dir#${DirName}}"
        echo "DIR: $Dir"
        ls "$Dir"
        if [[ ! -e "${Dir}" ]]; then
            echo "${Dir}: Directory not found"
        elif [[ ! -d "${Dir}" ]]; then
            echo "${Dir}: Not a directory"
        elif [[ "${DirExt}" == "${MDIREXT}" ]]; then
            local tmp
            echo "OMIT $Dir"
            # Omit mdirs
        else
            echo "PROCESS $Dir"
            ( process_Dir )
        fi
    done
}

# Really simple default
process_Dir() {
    echo "PROCESSING: $Dir"
    process_subdirs
    process_FILES
}

# Default is clean
process_file() {
    echo "DELETED! $File"
}

