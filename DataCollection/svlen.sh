#!/bin/bash

[ $# -lt 1 ] && echo "wrong number of args" && exit 1
file=$1
txtnam=$(basename ${file})
while read line; do
	echo $line | grep -oE 'SVLEN\=[0-9]+'| grep -oE '[0-9]+'>>$txtnam.bd.txt
	echo $line | grep -oE 'SVLEN\=\-[0-9]+'| grep -oE '[0-9]+' >> $txtnam.bd.txt
done <$file 
exit 0
