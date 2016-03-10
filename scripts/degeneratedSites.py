# DegeneratedSites.py is script reading fasta file of transcript
# (we should include example files)
# the table of seq_id, f1, f2, f3 and f4 sites is printed on standard output

import sys
from Bio import SeqIO 

genetic_code_file = open('./data/genetic_code_stats.csv', "r")
#genetic_code_file = open(sys.argv[2], "r")

headerline = genetic_code_file.readline().split('\t')

f1_d = {}
f2_d = {}
f3_d = {}
f4_d = {}

for codon in genetic_code_file.readlines():
	codon = codon.split(',')
	k = codon[1][1:-1]
	f1_d[k] = int(codon[4])
	f2_d[k] = int(codon[5])
	f3_d[k] = int(codon[6])
	f4_d[k] = int(codon[7])

# /Volumes/dump/data/snp/timema/orfs/Tdi3.transdecoder.cds.fa
print('transcript_id', 'f1', 'f2', 'f3', 'f4', sep='\t')
for seq_record in SeqIO.parse(sys.argv[1], "fasta"):
	seqlen = len(seq_record)
	f1 = 0; f2 = 0; f3 = 0; f4 = 0;
	for sw in range(0, seqlen, 3):
		f1 += f1_d[str(seq_record.seq[0+sw:3+sw])]
		f2 += f2_d[str(seq_record.seq[0+sw:3+sw])]
		f3 += f3_d[str(seq_record.seq[0+sw:3+sw])]
		f4 += f4_d[str(seq_record.seq[0+sw:3+sw])]
	print(seq_record.name, f1, f2, f3, f4, sep='\t')
