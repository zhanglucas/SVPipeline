# Breakdancer v1.4.5

Breakdancer utilizes read pair and split read method to detect structure variance.

Please download Breakdancer v1.4.5 (the latest version) from the github page https://github.com/genome/breakdancer/releases

Running breakdancer does not require reference genome, and the process consists the following steps:

  1. Generate a configuration file from the original bam file (fast)
  2. SV calling using the configuration file and bam file (~ 4 hours each whole genome)
  3. Convert the SV calling result to vcf file (fast)

Please note: 

Step 1 relies on the script bam2cfg.pl in perl folder of breakdancer. If initial running reports error that Statistics or GD::Graph module was not installed, install perl5 that contains the module and go to bam2cfg.pl to specify the location of the module (use lib location_of_the_module). This should at least solve the Statistics module problem. If GD::Graph module still not work, comment out the line requiring the module (#use GD::Graph::histogram;), as it is not necessary in structure variance calling.
