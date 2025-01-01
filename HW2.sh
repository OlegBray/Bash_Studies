#! /bin/bash

md5_encryption(){
    file="$1"
    checksum=($(md5sum "$file"))
    echo $checksum
}

input_check(){
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <PATH> <PATH>"
        exit 1
    fi

    dir1=$1
    dir2=$2
    delete_files="false"

    if [ -L "$1" ]; then
        echo "$1 path is a symbolic link and cannot be executed."
        exit 30
    elif [ -L "$2" ]; then
        echo "$2 path is a symbolic link and cannot be executed."
        exit 30
    elif [ ! -d "$1" ] || [ ! -d "$2" ]; then
        echo "The input is not a valid path, please repeat."
        exit 20
    elif [ "$1" == "$2" ]; then
        echo "The paths are the same, use different paths."
        exit 20
    fi

    if [ "$3" == "q" ]; then
        delete_files="true"
    fi

    for f1 in $(find "$dir1" -type f); do
        md5culc1=$(md5_encryption "$f1")
        echo "$md5culc1"

        for f2 in $(find "$dir2" -type f); do
            md5culc2=$(md5_encryption "$f2")
            echo "$md5culc2"

            if [ "$md5culc1" == "$md5culc2" ]; then
                if [ "$delete_files" == "true" ]; then
                    echo "$f2 is deleted!"
                    rm "$f2"
                else
                    echo "<$f1 in $dir1> is a duplicate of <$f2 in $dir2>"
                fi
            fi
        done
    done
}

shopt -s globstar dotglob
input_check "$@"