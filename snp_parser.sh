#!/bin/bash

#filtered_snps and degenerate_pos folders should be created in the directory before
if [ -z "$1" ]; then
	echo "saving computed data to ./data/..."
	echo "...filtered_snps"
	echo "...degenerate_pos"
	mkdir -p './data/filtered_snps'
	mkdir -p './data/degenerate_pos'
else
	echo "saving computed data to  $1..."
	echo "...filtered_snps"
	echo "...degenerate_pos"
	
	echo "crating output folders in $1"
	mkdir -p $1'filtered_snps'
	mkdir -p $1'degenerate_pos'
	
	if [ -h './data/filtered_snps' ]
		then
			echo "./data/filtered_snps already exist, the output will be saved there."
		else
			echo "creating sybolic link of $1'filtered_snps' to ./data/"
			ln -s $1'filtered_snps' ./data/
		fi

	if [ -h './data/degenerate_pos' ]
		then
			echo "./data/filtered_snps already exist, the output will be saved there."
		else
			echo "creating sybolic link of $1'degenerate_pos' to ./data/"
			ln -s $1'degenerate_pos' ./data/
	fi	
	
fi

declare -a timemas=("Tdi" "Tps" "Tsi" "Tcm" "Tms" "Tce" "Tge" "Tpa" "Tte" "Tbi")

# Rscript ./scripts/genetic_code_parser.r - creates a genetic code (already created)


## now loop through the above array
#for sp in "${timemas[@]}"; do
#	python ./scripts/snp2codonVariants.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' $DATAPATH'filtered_snps/'$sp'.filtered.snps' > $DATAPATH'/snp_codons/'$sp'_snp_codons.csv'
#	python ./scripts/degeneratedSites.py $DATAPATH'orfs/'$sp'3.transdecoder.cds.fa' ./data/genetic_code_stats.csv > $DATAPATH'/degenerate_pos/'$sp'_degenerate_pos.csv'
#done
