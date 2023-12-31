#!/bin/bash

DIST_USAGE=$(df -hT | grep -vE 'tmp|File')
DISK_THRESHOLD=1
message=""

while IFS= read line
do
    usage=$(echo $line | awk '{print $6F}' | cut -d % -f1)
    partition=$(echo $line |awk '{print $1F}' )
    if [ $usage -ge $DISK_THRESHOLD ]
    then 
        message+="High disk usage on $partition : $usage \n"
    fi
done <<< $DIST_USAGE

echo -e "message : $message"

echo -e "$message" | mail -s "high disk usage" akhileshakhi1993@gmail.com