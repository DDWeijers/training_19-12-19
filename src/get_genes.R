#...load libraries...
library(dplyr)
library(biomaRt)
library(RCurl)
library(testthat)

#...call functions...
#...function find gene name from chromosomal location...
FindGene <- function(x)
{
  #...building fail safes, work in progress...
  expect_true(is.data.frame(x))
  #...function to check for presence of specific column names...
  test_that("check existance and column names of chromosome-defining column", {expect_true('CHROM'%in%colnames(x))})
  test_that("check existance and column names of start position-defining column", {expect_true('POS'%in%colnames(x))})
  test_that("check existance and column names of end position-defining column", {expect_true('END'%in%colnames(x))})
  #...select ensembl database, genes in hg38, server to be used...
  mart <- useEnsembl('ENSEMBL_MART_ENSEMBL', 'hsapiens_gene_ensembl', mirror="uswest")
  
  #...define the (number of) rows to perform the loop on...
  tot_lines = nrow(x)
  #...create an empty list to deposit the gene names in...
  all_genes = rep(NA, tot_lines)
  #...Start loop, define the startpoint...
  for(i in 1:tot_lines){
    print(i)
    #...Pull chromosome and position info from the input data...
    manta_chrom <- as.character(x$CHROM[i])
    manta_pos <-  as.character(x$POS[i])
    manta_end <-  as.character(x$END[i])
    #...This is a fail-safe, but I need to figure out what it does exactly...
    manta_end[is.na(manta_end)] = manta_pos[is.na(manta_end)]
    #...combine the data we pulled before...
    manta_data = list(chromosome_name=manta_chrom,start=manta_pos, end=manta_end)
    
    #...get gene names using bioMart...
    gene_names <- getBM(attributes="external_gene_name", 
                        filters= c("chromosome_name","start","end"), 
                        values= manta_data, 
                        mart=mart)
    #...write gene name to the corresponding row in empty file (it builds up, row by row)...
    all_genes[i] = gene_names
    
  }
  
}

#...(Gene) list to file...#
ListInFile <- function(x,y)
{
  #...specify the number of rows of the gene list...
  tot_lines = length(x)
  #...create an empty list to transfer gene names to(column to put in the input file later)...
  Gene1 = rep(NA, tot_lines)
  #...take the genes you found before out of the list...#
  for(i in 1:tot_lines){
    c_genes = unlist(x[i])
    #...paste the seperated genes, if they are multiple, seperate by pipe...
    c_genes = paste(c_genes, collapse="|")
    
    Gene1[i] = c_genes
  }
  #...create a new matrix, pasting the input file and gene name column together...
  manta_res = cbind(y, Gene1)
  
}

#...load data, input file is local!...
manta <- read.table("C:/Users/dweijers/documents/diploidSV.txt", header=TRUE, quote="", sep="\t", stringsAsFactors=FALSE)


#...execute FindGene...#
FindGene(manta)

#...execute ListInFile...#
ListInFile(all_genes, manta)

#...export file, location is local!...

sname = "C:/Users/dweijers/documents/diploidSV_anno.txt"
write.table(manta_res, file=sname, col.names=TRUE, row.names=FALSE, sep="\t", dec=",")