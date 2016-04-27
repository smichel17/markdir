#!/bin/bash

process_directory() {
    echo "DIR: $1"
    process_subdirs "$1"
    process_files "$1"
}

process_file() {
    echo "FILE: $1"
}
