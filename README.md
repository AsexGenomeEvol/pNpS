# TimemaTranscriptome
This repository was created for scripts counting synonimous and non-synonimous SNPs, furher analysis will be probably added as well.

## wraper scripts

**snp_parser.sh** - calls degeneratedSites.py and snp2codonVariants.py on data in the path give by first argument and caputure outputs at the same place, these folders with input and output will be linked to ./data directory

## computing scripts (called for analyses)
./scripts/**degeneratedSites.py** - reads a genetic code and transcriptome, printing a list of seq_name f1 f2 f3 f4, where fn are numbers of n-fold degenerated sites

./scripts/**snp2codonVariants.py** - reads a snp table and transcriptome, returning a list of seq_name ref_codon alt_codon transcript_length

./scripts/**SynSubsFreq.R** - counts the number of synonimous and nonsynonimous snp per species; this script whould be modified if the s/n snps should be computed per transcript

## precomputing scripts (called once to create a file)
./scripts/**genetic_code_parser.r** - reads a "./genetic_code.csv", saving to "genetic_code_stats.csv", codon, aa, number of n-folded sites per codon, possible synonimous changes of 1st, 2nd and 3rd position, this might be useful in the case that the non-standart genetic code will be used.

## data

./data/**genetic_code.csv** - general genetic code downloaded from http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1 and parsed into three column format; for another genetic code, just reformat it it the same way as this genetic_code is, replace it and delete _stats.csv file; stats will be computed automatically

./data/**genetic_code_stats.csv** - genetic code with computed stats: f1-f4 n-fold degenerates sites per codon, and number of theoretical synonimous substitutions per first, second or third position per codon.



## INPUT
 two folders are expected in the same direcotry:
- "filtered_snps" containing the snp ouput of varscan with naming "species.filtered.snps" (eg. Tce.filtered.snps)
- "orfs" containing the CDS fasta files from which snps where mined. Naming should be "species.cds.fa" (eg. Tce.cds.fa)

