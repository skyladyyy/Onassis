% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/Onassis-methods.R
\docType{methods}
\name{compare}
\alias{compare}
\alias{compare,Onassis-method}
\title{\code{compare}}
\usage{
compare(onassis, ...)

\S4method{compare}{Onassis}(onassis, score_matrix = NA, by = "row",
  fun_name = "wilcox.test", fun_args = list(), padj = FALSE)
}
\arguments{
\item{onassis}{instance of class \code{\link{Onassis-class}}}

\item{...}{Optional parameters}

\item{score_matrix}{a matrix of scores containing on the rows genomic units and on the columns the samples annotated in the entities}

\item{by}{'row' if the test refers to single genomic units in multiple conditions, 'col' if the test compares all the genomic units across different conditions. Defaults to row}

\item{fun_name}{name of the test to apply}

\item{fun_args}{list of arguments needed by the function}

\item{padj}{TRUE if multiple test correction is needed}
}
\value{
The results of the comparison between semantic classes. In case of one ontology a square matrix whose rows and columns contain the semantic sets. For each couple of semantic sets i and j if by is 'row' the element in the row i and column j is a data frame with biological entities (genes, regions..) and for each entity, the results of the statistics function and p.value. For multiple test functions if padj = TRUE then also the Bonferroni correction will be reported. For each couple of semantic sets i and j if by is 'col' the element at row i and column j is a couple of values with the result of the statistic and corresponding p.value
In case of two ontologies the result will be a list named with the first level semantic sets and each element of the list will be the result of the comparisons between second level semantic sets within first level semantic sets. Depending on the by parameter, the elements of the list will be matrices or vectors as for the one ontology case.
}
\description{
This method compares lists of scores (e.g. gene expression values, gene copy numbers, binding factors intensity) associated to the annotated entities (samples) of an Onassis object according to the semantic sets obtained from the annotation step. For Onassis objects annotated with a single ontology the method applies a test function to determine differences between subsets of the scores in one semantic set compared to subsets of scores in any other semantic set. For Onassis objects containing annotated entities with two ontologies, the first ensemble of semantic sets (e.g cell lines) will be used as the main container to orgnize samples and the comparisons will be carried out between the entities belonging to different semantic sets of the second ontology (e.g disease) within each semantic set defined from the first ontology.
}
\details{
The entities slot of an Onassis object can contain annotations with concepts from one ontology or two ontologies. The function compare separates these two scenarios. 

ONE ONTOLOGY CASE:
The entities (samples) are assigned to their corresponding semantic set (e.g. cell lines)
A score matrix should have as rows genomic units (gene names, genomic regions, mutation identifiers...) and as columns the identifiers of all the entities annotated and belonging to semantic sets found in the sample_id field. The score for each entry of the matrix can be any biological measurement (gene expression RPKMs, peak intensity, copy numbers... )
Importantly, each semantic set can contain a different number of annotated entities (samples) and thus a single vector of scores (in case only 1 entity belongs to 1 semantic set) or a subset of the columns of the scores matrix
If by is "row" then the function provided as fun_name will be applied to compare, genomic unit by genomic unit (rows of the score matrix), all the possible couples of semantic sets.
The function can be any multiple statistical test function taking as parameters:
 - two numeric vectors of potentially different lengths (for genomic unit in row i, n samples in semantic set 1 and m samples in semantic set 2)
 - other optional arguments needed by the function passed as a list in fun_args
 The function should always provide as result a "statistic" and "p.value"  
 In case the padj is set to TRUE the bonferroni correction will be applied for multiple tests
 If by is "col" then the function provided as fun_name will be applied  to the couples of semantic sets considering all the possible values for the genomic units. In this case the test function should take as parameters 
 - two matrices with potentially different number of columns
 - other optional arguments needed by the function can be passed as fun_args
TWO ONTOLOGIES CASE:
The comparisons in this case will be carried out considering for each semantic set defined from the primary ontology, all the possible couples of semantic sets generated from the second ontology (e.g. for each cell line, different diseases) within the first ontology semantic sets
}
\examples{
#Loading ChIP-seq data
geo_chip <- readRDS(system.file('extdata', 'vignette_data','GEO_human_chip.rds', package='Onassis'))
#Sampling 30 samples
geo_chip <- geo_chip[sample(nrow(geo_chip), 30) ,]
# Loading the obo ontology for cell lines
obo1 <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')
# Loading the obo ontology for diseases 
obo2 <- system.file('extdata', 'sample.do.obo', package='OnassisJavaLibs')
#Annotating cell lines
onassis_results1 <- annotate(geo_chip, 'OBO', dictionary=obo1)
#Annotating diseases
onassis_results2 <- annotate(geo_chip, 'OBO', dictionary=obo2)
# Creating a score matrix
n <- length(unique(geo_chip$sample_accession))
m <- 50
score_matrix <-   matrix(sample(0:1, m * n, replace = TRUE), m, n)
colnames(score_matrix) <- unique(geo_chip$sample_accession)
rownames(score_matrix) <- paste0('gene_', seq(1, m, 1))
# Merging the annotations from the two ontologies in a single object
my_onassis <- mergeonassis(onassis1 = onassis_results1, onassis2 = onassis_results2)
scores(my_onassis) <- score_matrix
# Comparing the scores associated to samples belonging to cell line semantic sets
# By default the wilcox.test will be applied to each of the 50 genes 
scores(onassis_results1) <- score_matrix
gene_by_gene_cell_differences <- compare(onassis_results1)
head(gene_by_gene_cell_differences[1,2])
# Applying the same wilcox.test but obtaining a multiple test correction
gene_by_gene_cell_differences_ADJ <- compare(onassis_results1, padj=TRUE)
head(gene_by_gene_cell_differences_ADJ[1,2])
# Comparing disease genes across all the tissue semantic sets with wilcox.test and applying Bonferroni correction
gene_by_gene_disease_differences <- compare(my_onassis, by='row', padj=TRUE, fun_name='wilcox.test')
# Comparing diseases in cell line semantic sets
disease_differences <- compare(my_onassis, by='col', fun_name='wilcox.test')
# Using a personalized function
mykruskal <- function(x, y, params){
kruskal.test(as.list(c(x, y)))}
cell_differences_personalized <- compare(onassis_results1, by='col', fun_name='mykruskal')
}
