#!/bin/bash

process_Dir() {
    echo "PROCESSING DIR: $Dir"
    echo "DIR: $Dir"
    process_subdirectories
    # process_files "$1"
}

process_File() {
    echo "FILE: $1"
}
