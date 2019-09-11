#!/usr/bin/env Rscript

library(cn.mops)
Pathtobam = "/u/home/l/lukezhan/data_master/original_data/LP/"
setwd(Pathtobam)
BAMFiles <- list.files(path=Pathtobam,pattern=".bam$")
bamDataRanges <- getReadCountsFromBAM(BAMFiles)
trim(bamDataRanges)
(bamDataRanges)
data(cn.mops)
ls()
head(XRanges[,1:3])
resCNMOPS <- cn.mops(XRanges)
resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)
(resCNMOPS)
cnvs(resCNMOPS)[1:5]

##exporting results
library(cn.mops); data(cn.mops)
result <- calcIntegerCopyNumbers(cn.mops(XRanges))
segm <- as.data.frame(segmentation(result))
CNVs <- as.data.frame(cnvs(result))
CNVRegions <- as.data.frame(cnvr(result))
outdir="/u/scratch/l/lukezhan/cnmopsout/result.csv"
write.csv(segm,file=outdir)
write.csv(CNVs,file=outdir)
write.csv(CNVRegions,file=outdir)
