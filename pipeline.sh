#/bin/bash
cd /u/home/l/lukezhan/SVPipeline/Breakdancer/
qsub /u/home/l/lukezhan/SVPipeline/Breakdancer/bd_sub.job

cd /u/home/l/lukezhan/SVPipeline/Breakseq/
qsub /u/home/l/lukezhan/SVPipeline/Breakseq/bs_sub.job

cd /u/home/l/lukezhan/SVPipeline/CNVnator/scripts/
qsub /u/home/l/lukezhan/SVPipeline/CNVnator/scripts/CNVnator_large.job

cd /u/home/l/lukezhan/SVPipeline/Delly/
qsub /u/home/l/lukezhan/SVPipeline/Delly/delly_sub.job

cd /u/home/l/lukezhan/SVPipeline/LUMPY/scripts/ 
pwd
./4-23-18lumpy_submission_shell_HZ.sh
qsub /u/home/l/lukezhan/SVPipeline/Manta/Manta.job

cd /u/home/l/lukezhan/SVPipeline/cn.mops/
qsub /u/home/l/lukezhan/SVPipeline/cn.mops/cn_sub.job 
