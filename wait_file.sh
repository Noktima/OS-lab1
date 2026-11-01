#!/bin/bash
#Waiting for a file for 30 seconds

FILE="./tmp/ready"
MAX_TIME=30

TIME=0

while [ ! -f "${FILE}" ] && [ ${TIME} -lt ${MAX_TIME} ]; do
	sleep 2
	((TIME += 2))
done

if [ -f "${FILE}" ]; then 
	echo "Success: File ${FILE} found. Elapsed time ${TIME} seconds"
	exit 0
else
	echo "Error: Timeout reached (${MAX_TIME} seconds). File ${FILE} not found."  >&2
	exit 1
fi

