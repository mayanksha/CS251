#!/usr/bin/gawk -f
BEGIN{   
	counter=0
	string_count=0
	s=0
	x=0
	y=0
	z=0
	s1=0
}
{
	if($0 ~ /\/\*/ && $0 ~ /"/)
	{
		for(i=1; $i; i++)
		{
			if($i ~ /\/\*/)
				break;
			if($i ~ /"/)
			{
				n = i;
				s1++;
			}
		}
		if(s1%2!=0)
			counter--;

		for(i=1 ; $i ; i++)
		{
			if($i ~ /\/\*/)
				s2++;
			if($i ~ /\*\//)
				s3++;
			if($i ~ /"/)
				break;
		}  
		if(s1 != s2)
			string_count--; 
	}
	if(x  ==  0){
		flag = 0;
		for(i = 1; $i ;i++){
			if($i ~ /\/\//)
			{ flag=1;
				break;
			}
			if($i ~ /"/)
			{
				s++;
			}
		}
		if((s % 2) == 0 && flag == 1)
			counter++; 
		string_count += int((s+1)/2);
		s=0;
	}
	if($0 ~ /\/\*/){
		x++;
		y=NR;  
	}
	if($0 ~ /\*\//)
	{
		x--;
		z = NR;
		counter += ((z-y)+1);
	}
}
END {
	print counter "#" string_count;
}
