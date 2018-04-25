#!/bin/bash

#This script uses a helper script named q1.awk Please put both q1.sh and q1.awk in the same folder and run it.
if [ $# -ne 1 ]
then
	echo "You didn't given appropriate number of arguments. We just need 1 argument. Please re-run the script."
	exit -1
elif [ -d $1 ]
then
	echo "You gave a directory. The script is running."
else
	echo "You didn't give a directory. Please give a directory as argument and re-run the script."
	exit -1
fi
 
files=(`find $1 -name "*.c"`)
count_arr=(`echo "${files[*]}" | xargs -n1 ./q1.awk`)
comment=(`printf '%s\n' "${count_arr[@]}" |   grep -P "\d+#"  -o | sed -E 's/#//'`)
strings=(`printf '%s\n' "${count_arr[@]}" |   grep -P "#\d+"  -o | sed -E 's/#//'`)
total_strings=0
total_comments=0
#echo ${comment[*]}
#echo ${files[*]}
#echo ${strings[*]}
for i in `seq ${#files[*]}`;
do
	total_strings=$(( total_strings + strings[(($i - 1))] ))
	total_comments=$(( total_comments + comment[(($i - 1))] ))
	printf "${files[(($i - 1))]}\t has ${comment[(($i - 1))]} comments and ${strings[(($i - 1))]} strings.\n"
done
echo "Given directory '$1' has total $total_strings strings and $total_comments comments."
