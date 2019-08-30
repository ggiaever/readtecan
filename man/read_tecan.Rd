\name{read_tecan}
\alias{read_tecan}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Read Tecan
%%  ~~function to do ... ~~
}
\description{function to read tecan megellan spectrophotometer data
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
read_tecan(file)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{
%%     ~~Describe \code{file} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (file)
{
    y = read.table::read.delim(file, stringsAsFactors = F, check.names = F,
        header = F)
    ncoln = ncol(y)
    wells = paste0(rep(LETTERS[1:8], each = 12), rep(1:12, 8))
    nch = nchar(wells)
    wnch = which(nch == 2)
    wells[wnch] = paste0(rep(LETTERS[1:8], each = 9), 0, rep(1:9,
        8))
    names(y) = c("runtime", wells)
    y$runtime = gsub("s", "", y$runtime)
    y$runtime = as.numeric(y$runtime)
    my = reshape2::melt(y, id.vars = "runtime", value.name = "measure",
        variable.name = "well")
    my$plate = 0
    my$well = as.character(my$well)
    my = my[, c("plate", "well", "runtime", "measure")]
    my
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~growthrate }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~spectrophotometer }% __ONLY ONE__ keyword per line
