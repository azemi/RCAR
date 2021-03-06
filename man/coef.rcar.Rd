% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coef_rcar.R
\name{coef.rcar}
\alias{coef.rcar}
\title{Coefficients extraction from "rcar" or "cv.rcar" object}
\usage{
\method{coef}{rcar}(object, lambd)
}
\arguments{
\item{object:}{"rcar" or "cv.rcar" object.}

\item{lambd:}{Value of the penalty parameter lambda at which coefficients extraction is required. If not specified, the programme use the value of lambda corresponding the minimum mean cross-validated error.}
}
\value{
The function returns the retained rules and their corresponding parameters.
}
\description{
This functions extracts coefficients from a "rcar" or "cv.rcar" object at a single value of lambda.
}
\examples{

vote.rcar.1<-rcar(vote, y.rank = 1, s=0.2, c=0.8,lambd=0.169)
vote.rcar.2<-rcar(vote, y.rank = 1, s=0.2, c=0.8)

coef.rcar(vote.rcar.1)
coef.rcar(vote.rcar.2, lambd = 0.169)


vote.cv<-cv.rcar(vote, y.rank = 1, s=0.2, c=0.8)

coef.rcar(vote.cv, lambd=0.169)
coef.rcar(vote.rcar)
If the value of lambda is not specified, the programme uses the value of lambda corresponding the minimum mean cross-validated error.

}
