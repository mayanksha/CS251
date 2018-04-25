#!/usr/bin/env python3
import sys
import re
import subprocess
import numpy as np
iterations = 10

if(len(sys.argv) != 3):
    print("Insufficient number of args. First arg = params.txt, second = threads.txt\n")
    sys.exit(-1);

def file_len(fname):
    p = subprocess.Popen(['wc', '-l', fname], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    result, err = p.communicate()
    if p.returncode != 0:
        raise IOError(err)
    return int(result.strip().split()[0])

def file_reader(fname):
    with open(fname) as f:
        if (file_len(sys.argv[1]) == 1):
            for line in f:
                arr = [int(n) for n in line.split()] 
        else:
            for line in f:
                arr.append(int(line))
        return arr 

params = file_reader(sys.argv[1]);
threads = file_reader(sys.argv[2]);

def outputter():
    fname = open("data.out", "w")
    avg = open("avg.out", "w")
    timearr = []
    # fname.write("#Threads\t Inputs\t Time(in microsecs)\n")
    for (i) in threads:
        for (j) in params:
            for t in range(iterations):
                p = subprocess.Popen(["./a.out", str(j), str(i)], stdout=subprocess.PIPE)
                result, err = p.communicate()
                if (p.returncode != 0):
                    raise EnvironmentError(err)
                result = result.split()[3].decode("utf-8")
                timearr.append(result)
                fname.write("%s\t %s\t %s\n" %(i, j, result))
            # print(timearr)
            mean = np.mean([int(i) for i in timearr])
            variance = np.var([int(i) for i in timearr])
            timearr = []
            avg.write("%s\t %s\t %s\t %.2f\n"% (i, j, mean, variance))
    fname.close()
    avg.close()

def twoD():
    par_len = len(params)
    f = open("avg.out", "r")
    lines = f.readlines()
    print(len(lines))
    two = np.zeros((par_len + 1, 11))
    for t in range(par_len):
        print("T = %s" %t)
        a = 0
        two[t+1][0] = params[t]
        for i in range(0, len(lines), par_len):
            # print("i = %s" %i)
            if (i == 0):
                two[t+1][a+1] = (float(lines[i+t].split()[2]))
            else:
                two[t+1][a+1] = (two[t+1][1]/float(lines[i+t].split()[2]))
            a+=1
    for t in range(par_len):
        two[t+1][1] = 1
    for t in range(5):
        two[0][t+1] =  2**t;
    for t in range(5):
        two[0][t+6] =  2**t;
    for t in range(par_len):
        print("T = %s" %t)
        a = 5 
        two[t+1][0] = params[t]
        for i in range(0, len(lines), par_len):
            # print("i = %s" %i)
            two[t+1][a+1] = float(lines[i+t].split()[3])
            a+=1
    f.close()
    np.savetxt("speedup.out", two, fmt="%.2f")
    
outputter()
twoD()
sys.exit(0)
