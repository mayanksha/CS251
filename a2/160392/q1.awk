#!/usr/bin/gawk -f
BEGIN{   
	counter=0
	string_count=0
	incr_count=0
	balance=0
	p=0
	q=0
}
{
	#Checks the whole file for inv_commas or /* for comments
	if($0 ~ /\/\*/ && $0 ~ /"/)
	{
		for(i=1; $i; i++)
		{
			print $i
			if($i ~ /\/\*/)
			{
				break;
			}
			if($i ~ /"/)
			{
				n = i;
				temp++;
				print  "temp == " temp
			}
		}
		if(temp%2!=0)
			counter--;

		for(i=1 ; $i ; i++)
		{
			if($i ~ /\/\*/)
			{
				temp2++;
				print "temp2 == " temp2
			}
			if($i ~ /\*\//)
			{
				s3++;
			}
			if($i ~ /"/)
			{
				break;
			}
		}  
		}
		if(balance  ==  0){
			flag = 0;
			for(i = 1; $i ;i++){
				if($i ~ /\/\//)
				{ flag=1;
					break;
				}
				if($i ~ /"/)
				{
					incr_count++;
				}
			}
			if((incr_count % 2) == 0 && flag == 1)
				counter++; 
			string_count += int((incr_count+1)/2);
			incr_count=0;
		}
		if($0 ~ /\/\*/){
			balance++;
			p=NR;  
			print $p
		}
		if($0 ~ /\*\//)
		{
			balance--;
			q = NR;
			counter += ((q-p)+1);
		}
	}
	END {
		print counter "#" string_count;
	}
