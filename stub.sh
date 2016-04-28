#!/bin/bash

process_directory() {
    echo "PROCESSING DIR: $1"
    process_subdirectories "$1"
    process_files "$1"
}

process_file() {
    echo "FILE: $1"
}
