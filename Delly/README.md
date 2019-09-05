# Delly

Delly utilized read pair and split method to call structure variance. A reference genome is required for SV calling.

Please install binary version Delly v0.7.8 from the Github page https://github.com/dellytools/delly/releases or just download from the this folder. Note this is not the lastest version but it is a relative new version (released Jan 2018). The newest version v0.8.1 should also work.

We use Delly to run germline SV calling and a detailed instruction can be found on the developer's Github page. Note that we only run the first step of SV calling as FusorSV will perform the merging job at last.

Please note:

  1. bcftools module is not available on Orion cluster so it has to be manually installed.
  2. The vcf file converted from bcf file is pretty big because delly generates lots of low quality calling. However, FusorSV will ignore those low quality calling so we do not have to do anything about it. 

Script Usage: 

1. In delly_sub.job specify the provided variables: 
- input is the input BAM location/path
- outdir is the output directory path
- reference is the reference genome path 

2. In delly.sh you will need to specify the dir variable, which is where the directory where delly is installed. It is advised to use the binary linked file in Delly releases directly. 

3. In delly.sh you will also need to load bcftools, if on hoffman2 this scripts should load it with no issues but if you are using another system you will need to load bcftools accordingly. 
