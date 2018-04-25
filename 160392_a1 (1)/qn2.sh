#!/bin/bash
if [ $# -eq 0 ]
then
	echo "No directory argument was given. Please re-run the command with a directory as it's argument."
elif [ $# -eq 1 ] && [ -d $1 ]
then
	echo "Good. You gave a directory."
	dir_arr=($(du "$1" | sed -E 's@[0-9]+[[:space:]]+@@g' | xargs -n1 -I {} echo {}))
	for dir in ${dir_arr[*]};
	do
		files_name=()
		total_sent=0
		total_ints=0
		cd $dir > /dev/null
		files_arr=($(ls -p | grep -v /))
		num_tabs=$(echo "$dir" | grep -P '/' -o | wc -l)
		for j in ${files_arr[*]};
		do
			total=$(cat $j | grep -P  --color=auto '((-{0,1}[0-9]+\.?\s{0}[0-9]*)|(\.[0-9]+))\.?' -o | wc -l)
			num_floats=$(cat $j | grep -P '[.|?|!]{1}[0-9]+' --color=auto -o | wc -l)
			num_ints=$(($total - $num_floats))
			total_sent_stops=$( cat $j | grep -P '[.|?|!]d{0}' --color=auto -o | wc -l)
			sentences=$(($total_sent_stops - $num_floats))
			file=$(printf "$j-$sentences-$num_ints")
			files_name=(`echo ${files_name[*]}` $file)
			total_sent=$(($total_sent + $sentences))
			total_ints=$(($total_ints + $num_ints))
		done

		#Outputting Code
		#Directory Output
		for k in `seq 1 $num_tabs`:
		do
			printf "\t"
		done
			#printf "$j-$sentences-$num_ints\n"
		relative_name=$(echo ${dir##*/})
		echo "(D) $relative_name-$total_sent-$total_ints"

		#//Tabs for printing file names
		for t in ${files_name[*]};
		do
			for n in `seq 1 $(($num_tabs + 1))`:
			do
				printf "\t"
			done
			printf "(F) $t\n"
		done
		#sleep 2
		total_sent=0	
		total_ints=0
		cd - > /dev/null
	done
elif [ $# -eq 1 ] && ! [ -d $1 ]
then
	echo "$1 isn't a directory."
else [ $# -gt 1 ]
	echo "Too many arguments given. Just give 1 directory as argument."
fi

