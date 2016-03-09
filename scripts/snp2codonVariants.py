# snp2codonVariants is script reading fasta file of transcript and standardised snp file
# (we should be in example files)
# the table of seq_id, snp position, reference codon, alternative codon 
# and length of transcript to standart output

import sys
from Bio import SeqIO 

def warning(*objs):
    print("WARNING: ", *objs, file=sys.stderr)

ffile = open(sys.argv[1], "r")
# ffile = open("/Volumes/dump/data/snp/timema/orfs/Tdi3.transdecoder.cds.fa", "r")
# ffile = open("./test_data/fake_transcript.fa", "r")
orf_seq = SeqIO.to_dict(SeqIO.parse(ffile, "fasta"))
ffile.close()

snp_file = open(sys.argv[2], "r")
# snp_file = open("/Volumes/dump/data/snp/timema/filtered_snps/Tdi.filtered.snps", "r")

headerline = snp_file.readline().split('\t')
#snp = snp_file.readline().split('\t')

for snp in snp_file.readlines():
	snp = snp.split('\t')
	seq_id = snp[0]
	snp_pos = int(snp[1])
	snp_from = snp[2]
	snp_to = snp[3]
	snp_codon_i = (snp_pos - 1) % 3
	orf_from = snp_pos - 1 - snp_codon_i
	orf_to = orf_from + 3
	#print(orf_seq[seq_id]) #use any record ID
	orf = orf_seq[seq_id]
	total_length = len(orf.seq)
	trink = orf.seq[orf_from:orf_to]
	#control
	if snp_from != trink[snp_codon_i]:
		print('ERROR: snp is not matching position in the reference sequence')
		break
	trink_alt = list(trink)
	trink_alt[snp_codon_i] = snp_to
	print(seq_id,snp_pos,trink,"".join(trink_alt), total_length)