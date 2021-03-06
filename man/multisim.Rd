% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/similarity-methods.R
\docType{methods}
\name{multisim}
\alias{multisim}
\alias{multisim,list,list,character,character-method}
\title{\code{multisim}}
\usage{
multisim(similarities, annotations, sample1, sample2, aggregating_function)

\S4method{multisim}{list,list,character,character}(similarities,
  annotations, sample1, sample2, aggregating_function = "mean")
}
\arguments{
\item{similarities}{a list of Similarity instances, one for each ontology used to annotate the data}

\item{annotations}{a list of annotated data frames obtained using annotateDF or findEntities, one for each ontology}

\item{sample1}{the name of a sample in annotations}

\item{sample2}{the name of a sample in annotations}

\item{aggregating_function}{A function used to aggregate the single similarities obtained from each ontology annotation. The function should be applied to a numeric vector. The default value is 'mean'}
}
\value{
The aggregate semantic similarity between the samples sample1 and sample2
}
\description{
This method computes the semantic similarity between samples annotated with different ontology terms from different ontologies
}
\examples{
ef <- new('EntityFinder')

opts <- CMoptions()
cell_dict_file <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')
sample_dict <- CMdictionary(cell_dict_file, outputDir=getwd(),
synonymType='ALL')
samples <- findEntities(ef, system.file('extdata', 'test_samples',
'test_samples.txt',
package='Onassis'), outDir=getwd(), multipleDocs=TRUE, configOpt=opts,
 cmDict=sample_dict)
d_dict_file <-  system.file('extdata', 'sample.do.obo', package='OnassisJavaLibs')
disease_dict <- CMdictionary(d_dict_file, outputDir=getwd(), synonymType='ALL')
disease <- findEntities(ef, system.file('extdata', 'test_samples',
'test_samples.txt', package='Onassis'),
 multipleDocs=TRUE, outDir=getwd(), configOpt=opts,
  cmDict=disease_dict)


cell_sim <- new('Similarity')
ontology(cell_sim) <- cell_dict_file

disease_sim <- new('Similarity')
ontology(disease_sim) <- d_dict_file

pairwiseConfig(cell_sim) <- listSimilarities()$pairwiseMeasures[9]
pairwiseConfig(disease_sim) <- listSimilarities()$pairwiseMeasures[9]
groupConfig(cell_sim) <- listSimilarities()$groupwiseMeasures[3]
groupConfig(disease_sim) <- listSimilarities()$groupwiseMeasures[3]
similarity <- multisim(list(cell_sim, disease_sim),
list(samples, disease),
as.character(as.vector(samples[1,1])),
as.character(as.vector(samples[5,1])), 'mean')
}
