# http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1 parsed

genetic_code <- read.csv('./data/genetic_code.csv', row.names = 1)

# path to data as argument can be an argument
data_path <- './data/snp_codons/'

# internal computing function
getSnpCount<- function(snp_table, gc){
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
synonimous = 0
nonsynonimous = 0
syn_nsyn_freq <- data.frame(spec = 'none',
                            syn_st = 1,
                            syn_nd = 1,
                            syn_rd = 1,
                            syn_total = synonimous, 
                            s_freq = synonimous / (synonimous + nonsynonimous), 
                            ns_st = 1,
                            ns_nd = 1,
                            ns_rd = 1,
                            nsyn_total = nonsynonimous,
                            ns_freq = 0)

for(sp_file in condon_files){
  snptable <- read.csv(sp_file, sep = '\t', header = F, col.names = c('fa','pos','ref','alt','fa_length'))
  
  stsnps <- substr(as.character(snptable$ref),2,3) == substr(as.character(snptable$alt),2,3)
  ndsnps <- substr(as.character(snptable$ref),1,1) == substr(as.character(snptable$alt),1,1) & 
            substr(as.character(snptable$ref),3,3) == substr(as.character(snptable$alt),3,3)
  rdsnps <- substr(as.character(snptable$ref),1,2) == substr(as.character(snptable$alt),1,2)
  
  syn_st <- getSnpCount(snptable[stsnps,], genetic_code)
  syn_nd <- getSnpCount(snptable[ndsnps,], genetic_code)
  syn_rd <- getSnpCount(snptable[rdsnps,], genetic_code)
  synonimous <- syn_st[1] + syn_nd[1] + syn_rd[1]
  nonsynonimous <- syn_st[2] + syn_nd[2] + syn_rd[2]
  
  syn_nsyn_freq <- rbind(syn_nsyn_freq, data.frame(spec = substr(sp_file,nchar(data_path)+1,nchar(data_path)+3),
                                                   syn_st = syn_st[1],
                                                   syn_nd = syn_nd[1],
                                                   syn_rd = syn_rd[1],
                                                   syn_total = synonimous, 
                                                   s_freq = synonimous / (synonimous + nonsynonimous),
                                                   ns_st = syn_st[2],
                                                   ns_nd = syn_nd[2],
                                                   ns_rd = syn_rd[2],
                                                   nsyn_total = nonsynonimous, 
                                                   ns_freq = nonsynonimous / (synonimous + nonsynonimous)
                                                   )
                         )
}
syn_nsyn_freq <- syn_nsyn_freq[-1,]

write.csv(syn_nsyn_freq,'./data/snp_counts.csv')