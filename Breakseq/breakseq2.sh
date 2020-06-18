#!/bin/bash

input=$1
outdir=$2
reference=$3
bwa=$4
samtools=$5
bplib=$6
filename=$(basename $input)

# Directory where breakseq is installed
dir=/u/home/l/lukezhan/breakseq2-2.2
toolName="BreakSeq(v2.2)"
mkdir $outdir

# -----------------------------------------------

# Start time and log
now="$(date)"

logfile=${outdir}/report_breakseq_v2.2.${filename}.log

printf "START\n" >> $logfile
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

res1=$(date +%s.%N)

# Create a work directory for the file for all outputs
work=${outdir}/${filename}

# Name the output vcf file
vcf=${outdir}/${filename}/${filename}.vcf

# SV calling
# python is required
# Have to specify the location of bwa and samtools
# breakpoint library for specific reference genome is required
python $dir/scripts/run_breakseq2.py --reference $reference --bams $input --work $work --bwa $bwa --samtools $samtools --bplib_gff $bplib 
# bplibs
# For hg 37 it should be
# --bplib /home/jluo/breakseq2_bplib_20150129.hg37/breakseq2_bplib_20150129.fna
# Similar for hg 19
# For hg 38 it should be 
# --bplib_gff /home/jluo/bplib.hg38.gff

# Unzip the folder
gunzip $work/breakseq.vcf.gz

# Extract the vcf file from unzipped file
mv $work/breakseq.vcf $vcf

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
