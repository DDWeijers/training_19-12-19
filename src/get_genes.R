#..load libraries..
library(dplyr)
library(biomaRt)
library(RCurl)

#..load gene information..
mart <- useEnsembl('ENSEMBL_MART_ENSEMBL', 'hsapiens_gene_ensembl', mirror="uswest")

#..load data..
manta <- read.table("d:/Course_write_reproducible_code/diploidSV.txt", header=TRUE, quote="", sep="\t", stringsAsFactors=FALSE)

#..get gene 1..
tot_lines = nrow(manta)
all_genes = rep(NA, tot_lines)
for(i in 1:tot_lines){
print(i)
  #..prepare input data..
  manta_chrom <- as.character(manta$CHROM[i])
  manta_pos <-  as.character(manta$POS[i])
  manta_end <-  as.character(manta$END[i])
  manta_end[is.na(manta_end)] = manta_pos[is.na(manta_end)]
  manta_data = list(chromosome_name=manta_chrom,start=manta_pos, end=manta_end)
  
  #..get gene names..
  gene_names <- getBM(attributes="external_gene_name", 
                      filters= c("chromosome_name","start","end"), 
                      values= manta_data, 
                      mart=mart)
  all_genes[i] = gene_names
}

#..convert gene list to text..
tot_lines = length(all_genes)
Gene1 = rep(NA, tot_lines)
for(i in 1:tot_lines){
  c_genes = unlist(all_genes[i])
  c_genes = paste(c_genes, collapse="|")
  
  Gene1[i] = c_genes
}

manta_res = cbind(manta, Gene1)

sname = "d:/Course_write_reproducible_code/diploidSV_anno.txt"
write.table(manta_res, file=sname, col.names=TRUE, row.names=FALSE, sep="\t", dec=",")