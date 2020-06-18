input=$1
outdir=$2
reference=$3
filename=$(basename $input)

# This is not the job submission file, use delly_sub.job to submit jobs

# Directory where binary delly file is installed
dir=/u/home/l/lukezhan

toolName="Delly"
#mkdir $outdir
. /u/local/Modules/default/init/modules.sh
module load bcftools
# -----------------------------------------------

# Start time and log
now="$(date)"

logfile=${outdir}/report_delly.${filename}.log

printf "START\n" >> $logfile
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

res1=$(date +%s.%N)

# Name the output files

bcf=${outdir}/LP600.bcf
vcf=${outdir}/${filename}.vcf

# SV calling
$dir/delly_v0.7.8_linux_x86_64bit call -n -g $reference -o $bcf $input

# Convert the binary files to vcf files, bcftool required


bcftools view $bcf > $vcf

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
