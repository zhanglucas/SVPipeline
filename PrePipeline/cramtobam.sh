#!/bin/bash

input=$1

. /u/local/Modules/default/init/modules.sh
module load samtools
echo ${input}
samtools view -b -T /u/home/l/lukezhan/refgenome/GRCh38_full_analysis_set_plus_decoy_hla.fa -o /u/scratch/l/lukezhan/sample_bams/$(basename ${input}).bam ${input}.cram

/u/home/l/lukezhan/sambamba-0.6.8 markdup /u/scratch/l/lukezhan/sample_bams/$(basename ${input}).bam
/u/home/l/lukezhan/sambamba-0.6.8 index /u/scratch/l/lukezhan/sample_bams/$(basename ${input}).bam
