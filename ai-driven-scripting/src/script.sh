#!/bin/bash

# Provided input data
input_data=$(cat <<EOF
8       /Docker
0       /bin
4       /boot
0       /dev
4124    /etc
152     /home
2080    /init
0       /lib
16      /lost+found
4       /media
0       /proc
1372    /run
0       /sys
EOF
)

# Process the input data
# Filter out directories with size 0
filtered_data=$(echo "$input_data" | awk '$1 > 0')

# Sort the directories by size in descending order and extract the top three

top_three=$(echo "$input_data" | sort -nrk1 | head -n 3)

# Extract directory names and sizes
dir_names=$(echo "$top_three" | awk '{print $2}')
dir_sizes=$(echo "$top_three" | awk '{print $1}')

dir_name_line=$(echo "$dir_names" | tr '\n' ' ')
dir_size_line=$(echo "$dir_sizes" | tr '\n' ' ')

sorted_output=$(echo -e "$dir_name_line"'\n\n'"$dir_size_line")

echo "$sorted_output"