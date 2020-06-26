#!/bin/bash

[ $# -lt 1 ] && echo "wrong number of args" && exit 1
file=$1
txtname=$(basename ${file})
while read line; do
	echo $line | grep -oE 'chr[0-9]+'| grep -oE '[0-9]+' >> $txtname.delly.txt
done <$file
exit 0
~      	
