#!/bin/bash

process_Dir() {
    echo "PROCESSING DIR: $Dir"
    process_subdirs
    process_FILES
}

process_File() {
    echo "FILE: $File"
}
