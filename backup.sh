#!/bin/bash
#Script for backup dir

if [ "$#" -eq 0 ]; then 
	echo "Error: Missing argument" >&2
	echo "Usage: $0 <target_directory>"
	exit 1
fi

if [ "$#" -gt 1 ]; then
	echo "Error: too many arguments" >&2
	echo "Usage: $0 <target_directory>"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "Error: Directory $1 not found" >&2
	exit 1
fi 


TIME=$(date +%Y%m%d_%H%M%S)

mkdir -p tmp

ARCHIVE_PATH="/tmp/backup_${TIME}.tar.gz"

echo "Started backup of $1"

trap 'echo "Interrupted by user. Cleaning up..." >&2; rm -f "${ARCHIVE_PATH}.part"; exit 130' INT TERM

tar -czf "${ARCHIVE_PATH}.part" "$1"


if [ $? -ne 0 ]; then
	echo "Error: something went wrong during compressing" >&2
	exit 1
fi


mv "${ARCHIVE_PATH}.part" "${ARCHIVE_PATH}"
echo "Success! Archive saved as: ${ARCHIVE_PATH}"


