#!/bin/bash
travel_dir() {
	local files_name=()
	local total_sent=0
	local total_ints=0
	#cd $1 > /dev/null
	local files_arr=($(ls -p | grep -v /))
	#num_tabs=$(echo "$dir" | grep -P '/' -o | wc -l)
	#echo  ${files_arr[*]} 
	for j in ${files_arr[*]};
	do
		local total=$(cat $j | grep -P  --color=auto '((-{0,1}[0-9]+\.?\s{0}[0-9]*)|(\.[0-9]+))\.?' -o | wc -l)
		local num_floats=$(cat $j | grep -P '[.|?|!]{1}[0-9]+' --color=auto -o | wc -l)
		local num_ints=$(($total - $num_floats))
		local total_sent_stops=$(cat $j | grep -P '[.|?|!]d{0}' --color=auto -o | wc -l)
		local sentences=$(($total_sent_stops - $num_floats))
		file=$(printf "$j-$sentences-$num_ints")
		#printf "$j-$sentences-$num_ints \n\n\n"
		local files_name=(`echo ${files_name[*]}` $file)
		total_sent=$(($total_sent + $sentences))
		total_ints=$(($total_ints + $num_ints))
	done
	echo "$total_sent:$total_ints" 
	echo "$total_sent:$total_ints"  >&2
	#cd - > /dev/null
}

travel_tree(){
	# First arg = directory path 
	# Second arg = Depth of directory
	#echo "RECURSED ****************************" >&2
	local depth=$2 
	local pwd="$PWD"
	cd $1
	local all_dir=(`ls -d */ 2>/dev/null`)
	local files_present=(`ls -p | grep -v /`)
	#echo ${all_dir[*]} >&2
	if [ ${#all_dir[*]} -eq 0 ]
	then
		echo "No more files Current directory ==== ${PWD##*/}" >&2
		#Case when you are deepest in the tree and you want to operate on the files 
		local sent_int=$(travel_dir $1)
		local num_sent=$(echo $sent_int | grep -P "^\d+:" -o | sed -E 's@:@@g')
		local num_ints=$(echo $sent_int | grep -P ":\d+:" -o | sed -E 's@:@@g')
		#echo "$sent_int:$depth"
	#elif [ ${#files_present[*]} -ne 0 ]
	#then
		#local sent_int=$(travel_dir $1)
		#local num_sent=$(echo $sent_int | grep -P "^\d+:" -o | sed -E 's@:@@g')
		#local num_ints=$(echo $sent_int | grep -P ":\d+:" -o | sed -E 's@:@@g')
		#echo "$sent_int:$depth"
	else 
		#echo "Current directory ==== ${PWD##*/}" >&2
		(( depth++ ))
		local i
		for i in ${all_dir[*]} 
		do
			local values=$(travel_tree $i $depth)
			local sent_int=$(travel_dir $1)
			local num_sent=$(echo $sent_int | grep -P "^\d+:" -o | sed -E 's@:@@g')
			local num_ints=$(echo $sent_int | grep -P ":\d+:" -o | sed -E 's@:@@g')
			local present_depth=$(echo $values | grep -P ":\d+$" -o | sed -E 's@:@@g')
			#echo "$sent_int:$depth"
			#printf "\t\t\t Polluting ** local values = $values\n" >&2
			printf "\t\t\t Polluting ** num_sent  = $num_sent\n" >&2
			printf "\t\t\t Polluting ** num_ints  = $num_ints\n" >&2
			#printf "\t\t\t Polluting ** present_depth  = $present_depth\n" >&2
			#printf "\t\t\t  \n"
			#travel_tree $i $depth
		done
	fi
	cd $pwd
}


if [ $# -eq 0 ]
then
	echo "No directory argument was given. Please re-run the command with a directory as it's argument."
elif [ $# -eq 1 ] && [ -d $1 ]
then
	echo "Good. You gave a directory."
	travel_tree $1 1
	#dir_arr=($(du "$1" | sed -E 's@[0-9]+[[:space:]]+@@g' | xargs -n1 -I {} echo {}))
	#for dir in ${dir_arr[*]};
	#do
		#Outputting Code
		#Directory Output
		#for k in `seq 1 $num_tabs`:
		#do
			#printf "\t"
		#done
		#printf "$j-$sentences-$num_ints\n"
		#relative_name=$(echo ${dir##*/})
		#echo "(D) $relative_name-$total_sent-$total_ints"

		#//Tabs for printing file names
		#for t in ${files_name[*]};
		#do
			#for n in `seq 1 $(($num_tabs + 1))`:
			#do
				#printf "\t"
			#done
			#printf "(F) $t\n"
		#done
		#sleep 2
		cd - > /dev/null
elif [ $# -eq 1 ] && ! [ -d $1 ]
then
	echo "$1 isn't a directory."
else [ $# -gt 1 ]
	echo "Too many arguments given. Just give 1 directory as argument."
fi



