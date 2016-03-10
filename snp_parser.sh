#!/bin/bash

DATAPATH=/home/jens/Desktop/Timema_project/polymorphism/polymorphism_computation/
declare -a timemas=("Tdi" "Tps" "Tsi" "Tcm" "Tms" "Tce" "Tge" "Tpa" "Tte" "Tbi")

# Rscript ./scripts/genetic_code_parser.r

#filtered_snps and degenerate_pos folders should be created in the directory before
mkdir $DATAPATH'filtered_snps'
mkdir $DATAPATH'degenerate_pos'

## now loop through the above array
for sp in "${timemas[@]}"; do
	python ./scripts/snp2codonVariants.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' $DATAPATH'filtered_snps/'$sp'.filtered.snps' > $DATAPATH'/snp_codons/'$sp'_snp_codons.csv'
	python ./scripts/degeneratedSites.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' ./data/genetic_code_stats.csv > $DATAPATH'/degenerate_pos/'$sp'_degenerate_pos.csv'
done
