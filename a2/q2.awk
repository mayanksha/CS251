#!/usr/bin/gawk -f
BEGIN{
       x=0
}
{
     if($2 == "IP")
        {
          packets[$3" - "$5]++;
          split($1, time, ":");
          #Split the time
          temp[$3" - "$5]=time[3];
           if(arr1[$3" - "$5] == 0)
            {arr2[$3" - "$5]=time[3];
             arr1[$3" - "$5]=1;
            }
             temp2[$3" - "$5]=temp[$3" - "$5]-arr2[$3" - "$5];
        }
     if($NF > 0 )
         { data_packets[$3" - "$5]++;
           data_bytes[$3" - "$5]+=($NF);
         }
     else
       {
          data_packets[$3" - "$5]+=0;
          data_bytes[$3" - "$5]+=0;
        }
}
END{
    for(i in packets)
        print i " #packets= " packets[i] " #datapackets= " data_packets[i] " #databytes= " data_bytes[i] " #retrans= 0 xput= " int (data_bytes[i]/(temp2[i])) " bytes/sec";
}
