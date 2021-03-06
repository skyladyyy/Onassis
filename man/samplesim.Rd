% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/similarity-methods.R
\docType{methods}
\name{samplesim}
\alias{samplesim}
\alias{samplesim,Similarity,character,character,data.frame-method}
\title{\code{samplesim}}
\usage{
samplesim(object, sample1, sample2, annotated_df)

\S4method{samplesim}{Similarity,character,character,data.frame}(object,
  sample1, sample2, annotated_df)
}
\arguments{
\item{object}{instance of class \code{\link{Similarity-class}}}

\item{sample1}{A sample ID with its annotations available in a data frame}

\item{sample2}{A sample ID with its annotations available in a data frame}

\item{annotated_df}{data frame with annotations obtained using entityFinder. The data frame should have at least a column named 'sample_id' with the sample identifier and a column named 'term_url' with the URL of the ontology terms annotating the sample. The ontology terms must belong to the ontology loaded in the Similarity class.}
}
\value{
The semantic similarity between the samples sample1 and sample2
}
\description{
This method computes the semantic similarity between two named samples annotated with a group of ontolgy terms belonging to the same ontology
}
\examples{
sim <- new('Similarity')

pairwiseConfig(sim) <- listSimilarities()$pairwiseMeasures[9]
groupConfig(sim) <- listSimilarities()$groupwiseMeasures[3]
ef <- new('EntityFinder')
opts <- CMoptions()
obo <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')
ontology(sim) <- obo
sample_dict <- CMdictionary(inputFileOrDb=obo, outputDir=getwd(), synonymType='ALL')
sra_chip_seq <- readRDS(system.file('extdata', 'vignette_data', 'GEO_human_chip.rds',
  package='Onassis'))
chipseq_dict_annot <- EntityFinder(sra_chip_seq[1:20,c('sample_accession', 'title',
 'experiment_attribute', 'sample_attribute', 'description')], dictionary=sample_dict,
  options=opts)
s <- samplesim(sim, as.character(as.vector(chipseq_dict_annot$sample_id[1])),
as.character(as.vector(chipseq_dict_annot$sample_id[7])) , chipseq_dict_annot)
}
