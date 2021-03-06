% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SimExtract.R
\name{SimExtract}
\alias{SimExtract}
\title{Function to extract extra information from SimDesign objects}
\usage{
SimExtract(object, what)
}
\arguments{
\item{object}{object returned from \code{\link{runSimulation}}}

\item{what}{character indicating what information to extract. Possible inputs
include \code{'errors'} to return a \code{tibble} object containing counts of any
error messages, \code{'warnings'} to return a \code{data.frame} object containing
counts of any warning messages, \code{'error_seeds'} to extract the associated
\code{.Random.seed} values associated with the ERROR messages, and \code{'results'}
to extract the simulation results if the option \code{store_results} was passed to
\code{\link{runSimulation}}}
}
\description{
Function used to extract any error or warnings messages, the seeds associated
with any error messages, and any analysis results that were stored in the
final simulation object.
}
\examples{

\dontrun{

Generate <- function(condition, fixed_objects = NULL) {
    int <- sample(1:10, 1)
    if(int > 5) warning('GENERATE WARNING: int greater than 5')
    if(int == 1) stop('GENERATE WARNING: integer is 1')
    rnorm(5)
}

Analyse <- function(condition, dat, fixed_objects = NULL) {
    int <- sample(1:10, 1)
    if(int > 5) warning('ANALYSE WARNING: int greater than 5')
    if(int == 1) stop('ANALYSE WARNING: int is 1')
    c(ret = 1)
}

Summarise <- function(condition, results, fixed_objects = NULL) {
    mean(results)
}

res <- runSimulation(replications = 100, seed=1234, verbose=FALSE,
                     generate=Generate, analyse=Analyse, summarise=Summarise)
res

SimExtract(res, what = 'errors')
SimExtract(res, what = 'warnings')
seeds <- SimExtract(res, what = 'error_seeds')
seeds[,1:3]

# replicate a specific error for debugging (type Q to exit debugger)
res <- runSimulation(replications = 100, load_seed=seeds[,1], debug='analyse',
                     generate=Generate, analyse=Analyse, summarise=Summarise)



}
}
\references{
Chalmers, R. P., & Adkins, M. C.  (2020). Writing Effective and Reliable Monte Carlo Simulations
with the SimDesign Package. \code{The Quantitative Methods for Psychology, 16}(4), 248-280.
\doi{10.20982/tqmp.16.4.p248}

Sigal, M. J., & Chalmers, R. P. (2016). Play it again: Teaching statistics with Monte
Carlo simulation. \code{Journal of Statistics Education, 24}(3), 136-156.
\doi{10.1080/10691898.2016.1246953}
}
\author{
Phil Chalmers \email{rphilip.chalmers@gmail.com}
}
