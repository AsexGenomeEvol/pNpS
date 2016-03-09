#!/bin/bash

DATAPATH=/Volumes/dump/data/snp/timema/
declare -a timemas=("Tdi" "Tps" "Tsi" "Tcm" "Tms" "Tce" "Tge" "Tpa" "Tte" "Tbi")

# Rscript ./scripts/genetic_code_parser.r

## now loop through the above array
for sp in "${timemas[@]}"; do
	python ./scripts/snp2codonVariants.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' $DATAPATH'filtered_snps/'$sp'.filtered.snps' > $DATAPATH'/snp_codons/'$sp'_snp_codons.csv'
	python ./scripts/degeneratedSites.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' ./data/genetic_code_stats.csv > $DATAPATH'/degenerate_pos/'$sp'_degenerate_pos.csv'
done
