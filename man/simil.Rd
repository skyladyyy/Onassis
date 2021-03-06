% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/Onassis-methods.R
\docType{methods}
\name{simil}
\alias{simil}
\alias{simil<-}
\alias{simil<-,Onassis-method}
\alias{simil,Onassis-method}
\title{\code{simil<-}}
\usage{
simil(object)

simil(object) <- value

\S4method{simil}{Onassis}(object) <- value

\S4method{simil}{Onassis}(object)
}
\arguments{
\item{object}{instance of class \code{\link{Onassis-class}}}

\item{value}{a matrix of similarities between the entities of an object of class \code{\link{Onassis-class}}}
}
\value{
the similarity matrix of an object of type \code{\link{Onassis-class}} in case of get, the new \code{\link{Onassis-class}} instance in case of set
}
\description{
Method to get and set the \code{similarity} slot of the class \code{\link{Onassis-class}}
}
\examples{
onassis <- Onassis()
simil(onassis) <- matrix()

o <- Onassis()
simil(o)

}
