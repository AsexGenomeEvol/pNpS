# http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes#SG1 parsed

genetic_code <- read.csv('./data/genetic_code.csv', row.names = 1)

data_path <- '/Volumes/dump/data/snp/timema/snp_codons/'
condon_files <- paste(data_path,c('Tbi_snp_codons.csv','Tcs_snp_codons.csv','Tge_snp_codons.csv',
                  'Tpa_snp_codons.csv','Tsi_snp_codons.csv','Tcm_snp_codons.csv',
                  'Tdi_snp_codons.csv','Tms_snp_codons.csv','Tps_snp_codons.csv',
                  'Tte_snp_codons.csv'), sep = '')
synonimous = 0
nonsynonimous = 0
syn_nsyn_freq <- data.frame(spec = 'none',
                            syn = synonimous, 
                            s_freq = synonimous / (synonimous + nonsynonimous),
                            nsyn = nonsynonimous, 
                            ns_freq = nonsynonimous / (synonimous + nonsynonimous)
)

for(sp_file in condon_files){
  snptable <- read.csv(sp_file, sep = '\t', header = F, col.names = c('fa','pos','ref','alt','fa_lenth'))
  for(i in 1:nrow(snptable)){
    ref <- as.character(snptable$ref[i])
    alt <- as.character(snptable$alt[i])
    
    refaa <- genetic_code$aminoa[genetic_code$seq == ref]
    altaa <- genetic_code$aminoa[genetic_code$seq == alt]
    
    if(refaa == altaa){
      synonimous = synonimous + 1
    } else {
      nonsynonimous =	nonsynonimous + 1
    }
  }
  
  syn_nsyn_freq <- rbind(syn_nsyn_freq, data.frame(
  							  spec = substr(sp_file,1+nchar(data_path),3+nchar(data_path)),
                              syn = synonimous, 
                              s_freq = synonimous / (synonimous + nonsynonimous), 
                              nsyn = nonsynonimous, 
                              ns_freq = nonsynonimous / (synonimous + nonsynonimous)
                        )                         )
}
syn_nsyn_freq <- syn_nsyn_freq[-1,]

