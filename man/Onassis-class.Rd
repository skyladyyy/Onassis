% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllClasses.R
\docType{class}
\name{Onassis-class}
\alias{Onassis-class}
\title{Onassis-class}
\description{
Onassis is a container class for annotating samples metadata with concepts from dictionaries/ontologies, creating semantic sets of unique annotations, computing the distances between different semantic sets and eventually comparing the different identified conditions.
}
\details{
The following methods can be applied to Onassis

\code{\link{annotate}} \cr
\code{\link{collapse}} \cr
\code{\link{compare}} \cr
\code{\link{dictionary}} \cr
\code{\link{simil}} \cr
\code{\link{entities}} \cr
\code{\link{scores}} \cr
\code{\link{sim}} \cr
}
\section{Slots}{

\describe{
\item{\code{dictionary}}{One or more input dictionaries to annotate samples metadata}

\item{\code{entities}}{a data frame containing the result of the annotation of the input with ontology terms}

\item{\code{similarity}}{A matrix of the similarities between the entries in the entities slot}

\item{\code{scores}}{An optional score matrix containing genomic units on the rows (genes, regions) and on the columns the elements on the rows of the entities slot}
}}

