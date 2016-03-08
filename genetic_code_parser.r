# http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1
# note, that different genetic code can be used if it is provided in the format as genetic_code.csv

genetic_code <- read.csv('./genetic_code.csv', row.names = 1)
genetic_code$f1 <- 0
genetic_code$f2 <- 0
genetic_code$f3 <- 0
genetic_code$f4 <- 0
genetic_code$s_st <- 0
genetic_code$s_nd <- 0
genetic_code$s_rd <- 0

for(line_index in 1:nrow(genetic_code)){
	trint <- genetic_code$seq[line_index]
	codon_line <- genetic_code[line_index,]
	
	#SNP of 1st position
	pos1 <- subset(genetic_code, substr(trint,2,3) == substr(genetic_code$seq,2,3))
	
	syn_st <- sum(codon_line$aa == pos1$aa)
	genetic_code[line_index,'s_st'] <- syn_st - 1
	genetic_code[line_index,3 + syn_st] <- genetic_code[line_index,3 + syn_st] + 1

	#SNP of 2nd position
	pos2 <- subset(genetic_code, substr(trint,1,1) == substr(genetic_code$seq,1,1) &
	                             substr(trint,3,3) == substr(genetic_code$seq,3,3))
	
	syn_nd <- sum(codon_line$aa == pos2$aa)
	genetic_code[line_index,'s_nd'] <- syn_nd - 1
	genetic_code[line_index,3 + syn_nd] <- genetic_code[line_index,3 + syn_nd] + 1

	#SNP of 3rd position
	pos3 <- subset(genetic_code, substr(trint,1,2) == substr(genetic_code$seq,1,2))
	
	syn_rd <- sum(codon_line$aa == pos3$aa)
	genetic_code[line_index,'s_rd'] <- syn_rd - 1
	genetic_code[line_index,3 + syn_rd] <- genetic_code[line_index,3 + syn_rd] + 1
}

if(all(rowSums(genetic_code[,4:7]) == 3)){
	print('Genetic code updated')
	print('Variables f1 - f4 gives number of n folded degenerate sites per codon')
	print('Variables s_{st, nd, rd} gives number of synonimous snps per st, nd or rd site')
}

write.csv(genetic_code,'genetic_code_stats.csv')
