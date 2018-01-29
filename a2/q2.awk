BEGIN{
       x=0
}
{
     if($2 == "IP")
        {
          arr1[$3" - "$5]++;
          split($1, time, ":");
          arr4[$3" - "$5]=time[3];
           if(arr6[$3" - "$5] == 0)
            {arr7[$3" - "$5]=time[3];
             arr6[$3" - "$5]=1;
            }
             arr5[$3" - "$5]=arr4[$3" - "$5]-arr7[$3" - "$5];
        }
     if($NF > 0 )
         { arr2[$3" - "$5]++;
           arr3[$3" - "$5]+=($NF);
              #split($9, dat, /,$/ );
              #if(dat[1] ~ /:/)
              #{split(dat[1], data, ":");
              #arr3[$3]+=((data[2]-data[1])+1);
              #}
               #else
               #arr3[$3]++;
         }
     else
       {
          arr2[$3" - "$5]+=0;
          arr3[$3" - "$5]+=0;
        }
}
END{
    for(i in arr1)
        print i " #packets= " arr1[i] " #datapackets= " arr2[i] " #databytes= " arr3[i] " # retrans= 0 #xput= " int (arr3[i]/(arr5[i]));
}
