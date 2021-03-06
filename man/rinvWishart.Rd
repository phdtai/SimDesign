% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rgenerate.R
\name{rinvWishart}
\alias{rinvWishart}
\title{Generate data with the inverse Wishart distribution}
\usage{
rinvWishart(n = 1, df, sigma)
}
\arguments{
\item{n}{number of matrix observations to generate. By default \code{n = 1}, which returns a single
symmetric matrix. If \code{n > 1} then a list of \code{n} symmetric matrices are returned instead}

\item{df}{degrees of freedom}

\item{sigma}{positive definite covariance matrix}
}
\value{
a numeric matrix with columns equal to \code{ncol(sigma)} when \code{n = 1}, or a list
  of \code{n} matrices with the same properties
}
\description{
Function generates data in the form of symmetric matrices from the inverse
Wishart distribution given a covariance matrix and degrees of freedom.
}
\examples{

# random inverse Wishart matrix given variances [3,6], covariance 2, and df=15
sigma <- matrix(c(3,2,2,6), 2, 2)
x <- rinvWishart(sigma = sigma, df = 15)
x

# list of matrices
x <- rinvWishart(20, sigma = sigma, df = 15)
x

}
\references{
Chalmers, R. P., & Adkins, M. C.  (2020). Writing Effective and Reliable Monte Carlo Simulations
with the SimDesign Package. \code{The Quantitative Methods for Psychology, 16}(4), 248-280.
\doi{10.20982/tqmp.16.4.p248}

Sigal, M. J., & Chalmers, R. P. (2016). Play it again: Teaching statistics with Monte
Carlo simulation. \code{Journal of Statistics Education, 24}(3), 136-156.
\doi{10.1080/10691898.2016.1246953}
}
\seealso{
\code{\link{runSimulation}}
}
\author{
Phil Chalmers \email{rphilip.chalmers@gmail.com}
}
