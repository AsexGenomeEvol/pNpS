# TimemaTranscriptome
This repository was created for scripts counting synonimous and non-synonimous SNPs, furher analysis will be probably added as well.

## computing scripts (called for analyses)
**degeneratedSites.py** - reads a genetic code and transcriptome, printing a list of seq_name f1 f2 f3 f4, where fn are numbers of n-fold degenerated sites

**snp2codonVariants.py** - reads a snp table and transcriptome, returning a list of seq_name ref_codon alt_codon transcript_length

## precomputing scripts (called once to create a file)
**genetic_code_parser.r** - reads a "./genetic_code.csv", saving to "genetic_code_stats.csv", codon, aa, number of n-folded sites per codon, possible synonimous changes of 1st, 2nd and 3rd position

## data
**genetic_code.csv**
**genetic_code_stats.csv**



