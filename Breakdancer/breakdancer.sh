#!/bin/bash

# This is not the job submission file. Please use bd_sub.job for job submission.

# Bam file
input=$1

# Output directory
outdir=$2

filename=$(basename $input)

# The directory containing breakdancer installed
dir='/u/home/l/lukezhan/breakdancer'
toolName="BreakDancer(v1.4.5)"
mkdir $outdir

# -----------------------------------------------

# Start time and log
now="$(date)"

logfile=${outdir}/report_breakdancer_v1.4.5.${filename}.log

printf "START\n" >> $logfile
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

res1=$(date +%s.%N)

# Name the output files
cfg=${outdir}/${filename}.cfg
call=${outdir}/${filename}.calls
vcf=${outdir}/${filename}.vcf

# Convert the original bam file to configuration file
perl $dir/perl/bam2cfg.pl $input > $cfg

# SV calling
$dir/build/bin/breakdancer-max $cfg > $call

# Convert the call file to vcf file
python $dir/tools/generateVCF.py $call

# End time
res2=$(date +%s.%N)
dt=$(echo "$res2-$res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
now="$(date)"
printf "%s --- TOTAL RUNTIME: %d:%02d:%02d:%02.4f\n" "$now" $dd $dh $dm $ds >> $logfile

now="$(date)"
printf "%s --- FINISHED RUNNING %s %s\n" "$now" "$toolName" >> $logfile

# -----------------------------------------------

printf "DONE\n" >> $logfile
