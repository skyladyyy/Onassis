% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/Onassis-methods.R
\docType{methods}
\name{dictionary}
\alias{dictionary}
\alias{dictionary<-}
\alias{dictionary<-,Onassis-method}
\alias{dictionary,Onassis-method}
\title{\code{dictionary<-}}
\usage{
dictionary(object)

dictionary(object) <- value

\S4method{dictionary}{Onassis}(object) <- value

\S4method{dictionary}{Onassis}(object)
}
\arguments{
\item{object}{instance of class \code{\link{Onassis-class}}}

\item{value}{the path of an OBO file}
}
\value{
The path of the dictionary in case of get, the instance of Onassis with new dictionary in case of set
}
\description{
Method to get and set the \code{dictionary} slot of the class \code{\link{Onassis-class}}
}
\examples{
onassis <- Onassis()
obo <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')
dictionary(onassis) <- obo
o <- Onassis()
dictionary(o)

}
