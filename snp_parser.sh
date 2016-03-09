#!/bin/bash

DATAPATH=/Volumes/dump/data/snp/timema/
declare -a timemas=("Tdi" "Tps" "Tsi" "Tcm" "Tms" "Tce" "Tge" "Tpa" "Tte" "Tbi")

## now loop through the above array
for sp in "${timemas[@]}"; do
	python snp2codonVariants.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' $DATAPATH'filtered_snps/'$sp'.filtered.snps' > $DATAPATH''$sp'_snp_codons.csv'
	python degeneratedSites.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' genetic_code_stats.csv > $DATAPATH''$sp'_degenerate_pos.csv'
done