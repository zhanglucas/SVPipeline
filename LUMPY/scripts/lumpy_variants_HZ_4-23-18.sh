#!/bin/bash
#$ -V
#$ -S /bin/bash
#$ -N LUMPY
#$ -cwd
#$ -o /u/home/l/lukezhan/joblogs
#$ -j y
#$ -m a
#$ -M zhanglucasjifeng@gmail.com
#$ -l h_data=15G,h_rt=20:00:00
. /u/home/l/lukezhan/SVPipeline/inputs.config
# To resubmit the failed lumpy jobs. Raises the h_data to 4G.
# path to file with bam_id's
BAMs_to_PROCESS=$input_single

# get the number of lines in txt file
number_bam=1

# set variables to pass to lumpy script
lumpy_folder=bipolar_lumpy_retry
scratch=/u/scratch/l/lukezhan

# In case of lumpy job failures, row number of failed samples in the bam file list (batch_all.list) were determined and put in array "list".
list=(115 123 223 386)
let number=$SGE_TASK_ID-1
l=${list[$number]}
sample_path_bam=$input_single
sample_name=`echo $sample_path_bam | sed 's/\/.*\///g' | sed 's/.dedup.realigned.recal.bam//g' `

echo $BAMs_to_PROCESS
echo $sample_name
echo $lumpy_folder
echo $scratch
echo $sample_path_bam

mkdir -p ${scratch}/${lumpy_folder}
cd ${scratch}/${lumpy_folder}
. /u/local/Modules/default/init/modules.sh
module load python/2.7.13
module load samtools/1.2
module load bedtools
module load R

# Colin used extract-sv-reads to extract "discordant read pair" bams and "split read" bams. Check https://github.com/hall-lab/extract_sv_reads for installation of extract-sv-reads.
/u/home/l/lukezhan/extract_sv_reads/build/bin/extract-sv-reads -e -i $sample_path_bam -s ${scratch}/${lumpy_folder}/${sample_name}.splitters.bam -d ${scratch}/${lumpy_folder}/${sample_name}.discord.bam
echo "indexing sv reads"
samtools index ${scratch}/${lumpy_folder}/${sample_name}.splitters.bam
samtools index ${scratch}/${lumpy_folder}/${sample_name}.discord.bam

# This step gets the statistics of the read length distribution from the bam file, which is required for lumpy running. Specify the path to "pairend_distro.py" in your lumpy-sv folder.
echo "lumpy working"
stats=$(samtools view -r ${sample_name} $sample_path_bam | tail -n+100000 | /u/home/l/lukezhan/lumpy-sv/scripts/pairend_distro.py -r 101 -X 4 -N 10000 -o ${sample_name}.histo | tail -n 1 | sed 's/[[:space:]]/:/' | awk '{split($0,stats,":"); print stats[2],stats[4]}')
MEAN=$(echo $stats | cut -f1 -d ' ')
STDEV=$(echo $stats | cut -f2 -d ' ')

# This is the lumpy running step. It takes in the "discordant read pair" bam file, "split read" bam file, and MEAN/STDEV generated from previous step. You can also specify Bedpe files from other algorithms as the input for the Generic module.
/u/home/l/lukezhan/lumpy-sv/bin/lumpy -P -mw 4 -tt 0 -pe id:${sample_name},bam_file:${sample_name}.discord.bam,histo_file:${sample_name}.histo,mean:${MEAN},stdev:${STDEV},read_length:101,min_non_overlap:101,discordant_z:5,back_distance:10,weight:1,min_mapping_threshold:20 -sr id:${sample_name},bam_file:${sample_name}.splitters.bam,back_distance:10,weight:1,min_mapping_threshold:20 > ${sample_name}.lumpy.vcf


# Delete the discordant and split read bam files to save space.
rm ${sample_name}.discord.bam
rm ${sample_name}.discord.bam.bai
rm ${sample_name}.splitters.bam
rm ${sample_name}.splitters.bam.bai

/u/project/zarlab/jhsul/bin/bam_to_fastq/bam_to_fastq_3
