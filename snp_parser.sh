#!/bin/bash

#filtered_snps and degenerate_pos folders should be created in the directory before
if [ -z "$1" ]; then
	echo "input data will be expected in ./data/..."
	echo "...orfs/"
	echo "...filtered_snps/"
	echo "computed data will be saved to ./data/..."
	echo "...snp_codons/"
	echo "...degenerate_pos/"
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
			echo "./data/filtered_snps already exist, the input is expected to be there."
		else
			echo "creating sybolic link of $1'filtered_snps' to ./data/"
			ln -s $1'filtered_snps' ./data/
	fi

	if [ -h './data/orfs' ]
		then
			echo "./data/orfs already exist, the input is expected to be there."
		else
			echo "creating sybolic link of $1'orfs' to ./data/"
			ln -s $1'orfs' ./data/
	fi

	if [ -h './data/degenerate_pos' ]
		then
			echo "./data/filtered_snps already exist, the output will be saved there."
		else
			echo "creating sybolic link of $1'degenerate_pos' to ./data/"
			ln -s $1'degenerate_pos' ./data/
	fi	
	
	if [ -h './data/snp_codons' ]
		then
			echo "./data/snp_codons already exist, the output will be saved there."
		else
			echo "creating sybolic link of $1'snp_codons' to ./data/"
			ln -s $1'snp_codons' ./data/
	fi
fi

if [ -f ./data/genetic_code_stats.csv ]
	then
		echo "using precomputed stats of genetics code ./data/genetic_code_stats.csv"
	else
		echo "computing stats of genetics code ./data/genetic_code.csv"
		Rscript ./scripts/genetic_code_parser.r
fi

declare -a timemas=("Tdi" "Tps" "Tsi" "Tcm" "Tms" "Tce" "Tge" "Tpa" "Tte" "Tbi")

## now loop through the above array
for sp in "${timemas[@]}"; do
	python ./scripts/snp2codonVariants.py './data/orfs/'$sp'3.transdecoder.cds.fa' './data/filtered_snps/'$sp'.filtered.snps' > './data/snp_codons/'$sp'_snp_codons.csv'
	python ./scripts/degeneratedSites.py './data/orfs/'$sp'3.transdecoder.cds.fa' ./data/genetic_code_stats.csv > './data/degenerate_pos/'$sp'_degenerate_pos.csv'
	echo "$sp ... Done"
done

Rscript ./scripts/SynSubsFreq.R
