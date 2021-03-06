#' Attach the simulation conditions for easier reference
#'
#' This function accepts the \code{condition} object used to indicate the design conditions
#' and makes the variable names available in the environment from which it is called. This
#' is useful primarily as a convenience function when you prefer to call the variable names
#' in \code{condition} directly rather than indexing with \code{condition$sample_size} or
#' \code{with(condition, sample_size)}, for example.
#'
#' The behavior of this function is very similar to \code{\link{attach}},
#' however it is environment specific, and
#' therefore only remains defined in a given function rather than in the Global Environment.
#' Hence, this function is much safer to use than the \code{\link{attach}}, which
#' incidentally should never be used in your code.
#'
#' @param condition a \code{data.frame} or \code{tibble} containing the \code{condition} names
#'
#' @param check logical; check to see if the function will accidentally replace previously defined
#'   variables with the same names as in \code{condition}? Default is \code{TRUE}, which will avoid
#'   this error
#'
#' @param attach_listone logical; if the element to be assign is a list of length one
#'   then assign the first element of this list with the associated name. This generally avoids
#'   adding an often unnecessary list 1 index, such as \code{name <- list[[1L]]}
#'
#' @seealso \code{\link{runSimulation}}, \code{\link{Generate}}
#' @references
#'
#' Chalmers, R. P., & Adkins, M. C.  (2020). Writing Effective and Reliable Monte Carlo Simulations
#' with the SimDesign Package. \code{The Quantitative Methods for Psychology, 16}(4), 248-280.
#' \doi{10.20982/tqmp.16.4.p248}
#'
#' Sigal, M. J., & Chalmers, R. P. (2016). Play it again: Teaching statistics with Monte
#' Carlo simulation. \code{Journal of Statistics Education, 24}(3), 136-156.
#' \doi{10.1080/10691898.2016.1246953}
#'
#' @export
#'
#' @author Phil Chalmers \email{rphilip.chalmers@@gmail.com}
#'
#' @examples
#' \dontrun{
#'
#' # does not use Attach()
#' Generate <- function(condition, fixed_objects = NULL) {
#'     N1 <- condition$sample_sizes_group1
#'     N2 <- condition$sample_sizes_group2
#'     sd <- condition$standard_deviations
#'
#'     group1 <- rnorm(N1)
#'     group2 <- rnorm(N2, sd=sd)
#'     dat <- data.frame(group = c(rep('g1', N1), rep('g2', N2)),
#'                       DV = c(group1, group2))
#'     dat
#' }
#'
#' # similar to above, but using the Attach() function instead of indexing
#' Generate <- function(condition, fixed_objects = NULL) {
#'     Attach(condition)
#'     N1 <- sample_sizes_group1
#'     N2 <- sample_sizes_group2
#'     sd <- standard_deviations
#'
#'     group1 <- rnorm(N1)
#'     group2 <- rnorm(N2, sd=sd)
#'     dat <- data.frame(group = c(rep('g1', N1), rep('g2', N2)),
#'                       DV = c(group1, group2))
#'     dat
#' }
#'
#' }
Attach <- function(condition, check = TRUE, attach_listone = TRUE){
    envir <- as.environment(-1L)
    if(check)
        if(any(ls(envir = envir) %in% names(condition)))
            stop(sprintf('Using Attach() will mask the previously defined variable(s): %s)',
                         ls(envir = envir)[ls(envir = envir) %in% names(condition)]), call. = FALSE)
    for(n in names(condition)){
        if(attach_listone && is.list(condition[[n]]) && length(condition[[n]]) == 1L){
            assign(n, condition[[n]][[1L]], envir = envir)
            next
        }
        assign(n, condition[[n]], envir = envir)
    }
    invisible()
}
