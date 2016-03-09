# TimemaTranscriptome
This repository was created for scripts counting synonimous and non-synonimous SNPs, furher analysis will be probably added as well.

## wraper scripts

snp_parser.sh - calles degeneratedSites.py and snp2codonVariants.py on data in the path specified in script (meant to be modified, do not commit changes of path please) and caputure outputs of both at defined place

## computing scripts (called for analyses)
**degeneratedSites.py** - reads a genetic code and transcriptome, printing a list of seq_name f1 f2 f3 f4, where fn are numbers of n-fold degenerated sites

**snp2codonVariants.py** - reads a snp table and transcriptome, returning a list of seq_name ref_codon alt_codon transcript_length

**SynSubsFreq.R** - reads data from specified path inside script (should match path in the snp_parser.sh) and count the number of synonimous and nonsynonimous snp per species; this script whould be modified if the s/n snps should be computed per transcript

## precomputing scripts (called once to create a file)
**genetic_code_parser.r** - reads a "./genetic_code.csv", saving to "genetic_code_stats.csv", codon, aa, number of n-folded sites per codon, possible synonimous changes of 1st, 2nd and 3rd position, this might be useful in the case that the non-standart genetic code will be used.

## data
**genetic_code.csv** - general genetic code downloaded from http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1 and parsed into three column format

**genetic_code_stats.csv** - genetic code with computed stats: f1-f4 n-fold degenerates sites per codon, and number of theoretical synonimous substitutions per first, second or third position per codon.



