#!/bin/bash
# Converts epoch timestamps to human-readable UTC timestamps.
# Copy this script to /usr/local/bin/, and chmod +x it.
# Usage: k logs <pod> -n <namespace> | fixts


# Test if there is a pipe on STDIN:
if test -p /dev/stdin
then
    echo "Data comes from STDIN"
    while read -r line
    do
      # Test if line starts with an exponential epoch timestamp, i.e., 1.650313266275081e+09:
      if [[ ${line} =~ ^[0-2]\.[0-9]+e\+[0-9]+[[:space:]] ]]
      then
        # Get the timestamp string:
        timestamp=$(echo ${line} | tr -s ' ' | cut -d ' ' -f 1)
        # Truncate to integer seconds (epoch seconds): 
        seconds=$(echo "${timestamp:0:11}" | sed 's/\.//')
        # Convert to UTC:
        utc=$(date -u -r "${seconds}")
        # Substitute the UTC string for the timestamp string:
        fixed=${line//"${timestamp}"/"${utc}"}
        # Report the fixed line:
        echo "${fixed}"
      else
        # No exponential epoch timestamp detected at start of line.  Just echo line:
        echo "${line}"
      fi
    done
fi


