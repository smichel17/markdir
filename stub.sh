#!/bin/bash

process_Dir() {
    process_subdirs
    process_files
}

process_File() {
    echo "FILE: $File"
}
