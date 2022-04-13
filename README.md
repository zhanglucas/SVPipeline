# SVPipeline

These are various algorithms used to build the structural variants pipeline currently in use by JaeHoon's lab at University of California Los Angeles. 
More algorithms will be added in the near future to ensure full intended functionality of the pipeline. 

# Important File Descriptions: 

1. If the data needs to be converted from cram to bam format, please use the cramtobamarray.job in the PrePipeline folder, which takes input from a text file named crams.list. This could be changed to any text file by just changing the file name in the aforementioned job file. 
2. Preprocessing the bams will be done automatically, meaning it will be sorted and deduplicated. 
3. Running the pipeline takes the input list from inputs.config, either give it a single file to run or the folder location to run as a batch. 
4. The output would be the various vcfs from each of the individual callers, with various useful statistics being gathered with the various .sh files in DataCollection 
  - chromdist.sh gathers chromosome distance 
  - cnvcalls.sh gatheres the calls 
  - len.sh gathers the length of the variant from formats which denote length using 'LEN='
  - svlen.sh gatheres the length of the variant from formats which denote length using 'SVLEN=' 
