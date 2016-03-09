import os

os.system("python ./scripts/snp2codonVariants.py ./test_data/fake_transcript.fa ./test_data/fake_snps > fake_sc.csv")
os.system("python ./scripts/degeneratedSites.py ./test_data/fake_transcript.fa ./data/genetic_code_stats.csv > fake_dp.csv")

codon_file = open('fake_sc.csv', "r")
codon_result_file = open('./test_data/fake_snp_codons', "r")
headerline = codon_file.readline().split(' ')


for codon_result_line in codon_result_file.readlines():
	ref, alt = codon_result_line.split(' ')
	computed = codon_file.readline().split(' ')
	print(ref,alt,computed)

os.system("rm fake_sc.csv")
os.system("rm fake_dp.csv")

