#!/bin/sh

# file='00400886539620110427180649646.jpg'
file=$@
echo $file
capture_datetime_full=$(mdls -raw -name kMDItemContentCreationDate $file)
# echo $capture_datetime_full

# Split by the space to get the components from: "2006-08-18 15:57:55 +0000"
capture_date=$(echo $capture_datetime_full | awk '{print $1}')
capture_time=$(echo $capture_datetime_full | awk '{print $2}')


# # Split by the dash '-' to get the date-components from: "2006-08-18"
year=$(echo $capture_date | awk -F- '{print $1}')
month=$(echo $capture_date | awk -F- '{print $2}')
day=$(echo $capture_date | awk -F- '{print $3}')
date=$year$month$day
# echo $date

# Split by the colon ':' to get the time from: "15:57:55"
hour=$(echo $capture_time | awk -F: '{print $1}')
minute=$(echo $capture_time | awk -F: '{print $2}')
time=$hour$minute
# echo $time

#concat the variables
date_time=$date$time 
echo $date_time
touch -m -t $date_time $file

echo "done"