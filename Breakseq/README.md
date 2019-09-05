# Breakseq2

Breakseq2 utilizes its own breakpoint library to call structure variance. 

Please download breakseq from https://github.com/bioinform/breakseq2/releases.

Instructions from the developer could be found here http://bioinform.github.io/breakseq2/

Please note:

  1. Python is needed for because the main script is written in python.
  2. Samtools and bwa modules are needed so they have to be manually installed on Orion cluster.
  3. Biopython module maybe needed depending whether there is an error during running.

For Breakpoint library
  - Breakpoint libraries for hg 19, 37 and 38 can be downloaded from this directory.
  - The libaries for hg 19 and 37 are created directly and that for hg 38 was created by lifting over from hg 37.
  - For hg 19 and hg 37, breakseq is able to call insertions, deletion and deplications, but for hg 38 it is only able to call deletions due to the limitation of breakpoint library.
