#!/usr/bin/env Rscript

library(cn.mops)
Pathtobam = "/u/home/l/lukezhan/data_master/original_data/LP/"
setwd(Pathtobam)
BAMFiles <- list.files(path=Pathtobam,pattern=".bam$")
bamDataRanges <- getReadCountsFromBAM(BAMFiles)
res <- cn.mops(bamDataRanges)
result <- calcIntegerCopyNumbers(cn.mops(XRanges))
segm <- as.data.frame(segmentation(result))
CNVs <- as.data.frame(cnvs(result))
CNVRegions <- as.data.frame(cnvr(result))
