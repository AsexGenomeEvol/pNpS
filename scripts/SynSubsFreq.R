# http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1 parsed

genetic_code <- read.csv('./data/genetic_code.csv', row.names = 1)

# path to data as argument can be an argument
data_path <- './data/snp_codons/'

# internal computing function
getSnpCount<- function(snp_table, gc){
  if(nrow(snp_table) == 0){
  	return(c(0,0))
  }
  s = 0
  ns = 0
  for(i in 1:nrow(snp_table)){
    
    ref <- as.character(snp_table$ref[i])
    alt <- as.character(snp_table$alt[i])
    
    refaa <- gc$aminoa[gc$seq == ref]
    altaa <- gc$aminoa[gc$seq == alt]
    
    if(refaa == altaa){
      s = s + 1
    } else {
      ns =	ns + 1
    }
  }
  return(c(s,ns))
}


condon_files <- paste(data_path,c('Tbi_snp_codons.csv','Tce_snp_codons.csv','Tge_snp_codons.csv',
                  'Tpa_snp_codons.csv','Tsi_snp_codons.csv','Tcm_snp_codons.csv',
                  'Tdi_snp_codons.csv','Tms_snp_codons.csv','Tps_snp_codons.csv',
                  'Tte_snp_codons.csv'), sep = '')

snp_freq_all <- species_reads <- data.frame(spec = numeric(0), 
											transcript =  numeric(0),  
											syn_st = numeric(0),
											syn_nd = numeric(0),
											syn_rd = numeric(0), 
											ns_st = numeric(0),
											ns_nd = numeric(0),
											ns_rd = numeric(0))


for(sp_file in condon_files){
  snptable <- read.csv(sp_file, sep = '\t', header = F, col.names = c('fa','pos','ref','alt','fa_length'))
  
  snp_freq <- data.frame(spec = substr(sp_file,nchar(data_path)+1,nchar(data_path)+3),
							transcript = levels(snptable$fa),
                            syn_st = NA,
                            syn_nd = NA,
                            syn_rd = NA, 
                            ns_st = NA,
                            ns_nd = NA,
                            ns_rd = NA)
  
  for(transc in snp_freq$transcript){
	  transcript_snp <- subset(snptable, snptable$fa == transc)
  
	  stsnps <- substr(as.character(transcript_snp$ref),2,3) == substr(as.character(transcript_snp$alt),2,3)
	  ndsnps <- substr(as.character(transcript_snp$ref),1,1) == substr(as.character(transcript_snp$alt),1,1) & 
				substr(as.character(transcript_snp$ref),3,3) == substr(as.character(transcript_snp$alt),3,3)
	  rdsnps <- substr(as.character(transcript_snp$ref),1,2) == substr(as.character(transcript_snp$alt),1,2)
	  
	  syn_st <- getSnpCount(transcript_snp[stsnps,], genetic_code)
	  syn_nd <- getSnpCount(transcript_snp[ndsnps,], genetic_code)
	  syn_rd <- getSnpCount(transcript_snp[rdsnps,], genetic_code)
  
	  snp_freq[transc == snp_freq$transcript,'syn_st'] <- syn_st[1]
	  snp_freq[transc == snp_freq$transcript,'syn_nd'] <- syn_nd[1]
	  snp_freq[transc == snp_freq$transcript,'syn_rd'] <- syn_rd[1]
  
	  snp_freq[transc == snp_freq$transcript,'ns_st'] <- syn_st[2]
	  snp_freq[transc == snp_freq$transcript,'ns_nd'] <- syn_nd[2]
	  snp_freq[transc == snp_freq$transcript,'ns_rd'] <- syn_rd[2]
  }
  
  snp_freq_all <- rbind(snp_freq_all,snp_freq)
}

snp_freq_all$syn_total <- snp_freq_all$syn_st + snp_freq_all$syn_nd + snp_freq_all$syn_rd
snp_freq_all$ns_total <- snp_freq_all$ns_st + snp_freq_all$ns_nd + snp_freq_all$ns_rd

snp_freq_all$sex <- 0
snp_freq_all$sex[snp_freq_all$spec %in% c('Tdi','Tsi','Tms','Tge','Tte')] <- 1

write.csv(snp_freq_all,'./data/snp_per_gene_counts.csv')