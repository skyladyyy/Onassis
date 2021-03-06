% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/CMdict-methods.R
\docType{methods}
\name{dictRef}
\alias{dictRef}
\alias{dictRef<-}
\alias{dictRef,CMdictionary-method}
\alias{dictRef<-,CMdictionary-method}
\title{\code{dictRef}}
\usage{
dictRef(.Object)

dictRef(.Object) <- value

\S4method{dictRef}{CMdictionary}(.Object)

\S4method{dictRef}{CMdictionary}(.Object) <- value
}
\arguments{
\item{.Object}{An instance of class \code{\link{CMdictionary}}}

\item{value}{the reference of a XML Conceptmapper dictionary file already created}
}
\value{
java reference to the Conceptmapper dictionary
}
\description{
This method retrieves and sets the java reference the conceptmapper dictionary
}
\examples{
dictionary <- new('CMdictionary')
dictRef(dictionary)
dictionary <- new('CMdictionary')
dict_file <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')
dictRef(dictionary) <- .jnew('java/io/File', dict_file)
}
