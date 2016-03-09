import os

print('computing metafiles \n ...')

os.system("python ./scripts/snp2codonVariants.py ./test_data/fake_transcript.fa ./test_data/fake_snps > fake_sc.csv")
os.system("python ./scripts/degeneratedSites.py ./test_data/fake_transcript.fa ./data/genetic_code_stats.csv > fake_dp.csv")

print('testing metafiles \n ...')

codon_file = open('fake_sc.csv', "r")
codon_result_file = open('./test_data/fake_snp_codons', "r")

for codon_result_line in codon_result_file.readlines():
	ref, alt = codon_result_line.split(' ')
	alt = alt[0:3]
	computed = codon_file.readline().split('\t')
	if ref != computed[2] or alt != computed[3]:
		print('Olala, something is wrong with the example, contact developer, he will fix it...')
		break;

if(ref == computed[2] and alt == computed[3]):
	print('snp2codonVariants looks good, deleting metafile fake_snps \n ...')
	os.system("rm fake_sc.csv")

else:
	print('The problem codons:',computed[2],computed[3],' should be ',ref,alt)
		
degesit_file = open('fake_dp.csv', "r")
degesit_line = degesit_file.readline()
degesit_line = degesit_file.readline().split('\t')
if degesit_line == ['t1', '6', '1', '0', '2\n']:
	print('degeneratedSites looks good, deleting metafile fake_dp \n ...')
	os.system("rm fake_dp.csv")
else:
	print('Olala, something is wrong with the example, contact developer, he will fix it...')
	print(degesit_line)
		
print('Done')