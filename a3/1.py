#!/usr/bin/env python3
import re
import sys
import string

minus_flag = 0
values = (string.digits + string.ascii_lowercase)
valid_reg = re.compile('^\-{0,1}[0-9a-zA-Z]+(\.{0,1}[0-9a-zA-Z]+)?$')

def base_n(x, base):
    if base == "10" :
        base = 10
        temp = 0
        x = x[::-1]
        for i in range(len(x)):
            j = values.find(x[i])
            if(j >= 10):
                sys.exit("Invalid Input!")
            t = (j)*(base**(i))
            temp += t
            # print("Temp = ", temp)
        return temp

    base = base_n(base, "10")
    temp = 0
    temp2 = x.split('.')
    # print(temp2)
    if(len(temp2) == 2):
        # print("Decimal found")
        x = temp2[1]
        for i in range(len(x)):
            j = values.find(x[i])
            if(j >= base):
                sys.exit("Invalid Input!")
            t = (j)*(1/(base**(i+1)))
            temp += t
            # print("Temp = ", temp)
    x = temp2[0]
    x = x[::-1]
    for i in range(len(x)):
        j = values.find(x[i])
        if(j >= base):
            sys.exit("Invalid Input")
        t = (j)*(base**(i))
        temp += t
        # print("Temp = ", temp)
    return temp 

def validate():
    if (len(sys.argv) !=  3):
        print("Please provide sufficient number of arguments (Two) and re run.")
        sys.exit
    elif (valid_reg.match(sys.argv[1]) == None):
        print("The input is not valid number.")
        sys.exit
    elif (base_n(sys.argv[2], "10") < 2 or base_n(sys.argv[2], "10") > 36):
        print("Base is out of range")
        sys.exit
    else:
        global minus_flag
        if(sys.argv[1].find('-') == 0):
            minus_flag = 1
            sys.argv[1] = sys.argv[1][1:]
        sys.argv[1] = sys.argv[1].lower()
        print(0 - (base_n(sys.argv[1], sys.argv[2]))) if (minus_flag) else print(base_n(sys.argv[1], sys.argv[2]));

validate()
