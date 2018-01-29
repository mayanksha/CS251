#!/bin/bash

tree(){
    space=$2
    if [ -d $1 ]
    then
        printf "%s" $space "-----|" $1
        printf "\n"
        cd $1
        space="$space-----|"
        for a in *
        do
            tree $a $space
        done
        cd ..
    else
        printf "%s" $space "-----|" $1
        printf "\n"
    fi
}    

cd $1
for file in *
do
    space="|"
    tree $file $space
done
