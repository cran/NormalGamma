\name{normgam.fit}
\alias{normgam.fit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Normal-gamma Maximum Likelihood Estimator}
\description{
Computes the Maximum Likelihood Estimator for the normal-gamma distribution, either from a normal-gamma distributed sample or from two samples respectively normal-gamma and normally distributed. 
}
\usage{
normgam.fit(X, N = NULL, par.init = NULL, lower = NULL, upper = NULL,
            control = NULL, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{
vector of normal-gamma distributed values.
}
  \item{N}{
vector of normal distributed values.
}
  \item{par.init}{
  vector of initial values for parameters (optional). \code{par.init[1]} and \code{par.init[2]} are the mean and standard deviation of the normal distribution, and \code{par.init[3]} and \code{par.init[4]} are the shape and scale parameters of the gamma distribution. See details for default initial values.

}
\item{lower, upper}{ Bounds on the variables for maximization (optional).}

  \item{control}{
 list of control parameters (see details).
}
 

  \item{verbose}{
  logical; if \code{TRUE} initial values of the parameters are printed. 
}
}
\details{

Likelihood maximization is run by the \code{R} function \code{\link{optimx}}. 

By default, maximization is run with the following control parameters:  the maximum number of iterations is equal to \code{1000} and the vector of scaling values for the parameters is \code{(par0[1], par0[2], par0[3]*par0[4],}  \code{sqrt(par0[3])*par0[4])/10} where \code{par0} is the vector of default initial parameters. In case of unsuccessful convergence, maximization is run with  \code{\link{optimx}} default control parameters.
A list of control parameters can also be chosen by the user (see \code{\link{optimx}}).
 
If \code{par.init == NULL}, the initial parameters are computed in two ways depending if \code{N} is \code{NULL} or not. If \code{N != NULL}, the initial parameters are computed following the method of the moments (see Plancade S., Rozenholc Y. and Lund E. (http://arxiv.org/abs/1112.4180)). If \code{N == NULL}, the initial parameters \code{(par0[1], par0[2])} of the normal distribution are computed following the RMA procedure of Xie Y., Wang X. and Story M. (2009) for the normal-exponential convolution model, and the initial parameters of the gamma distribution, computed following the method of the moments, are \code{ (par0[4] =  ( sd(X)^2 - par0[2]) / (mean(X) - par0[1]), par0[3] = (mean(X) - par0[1] /par0[4])}. Note that the RMA procedure for initial parameter computation when \code{N == NULL} stems from an heuristic adapted to microarray data. For parameters with different magnitude, user should specify initial parameters. 


}
\value{
 \item{par }{vector of estimated parameters; \code{par[1]} and \code{par[2]} are the mean and standard deviation of the normal distribution and \code{par[3]} and \code{par[4]} are the shape and scale parameters of the gamma distribution
}
  \item{lik }{value of the normal-gamma log-likelihood corresponding to \code{par}.}
  
  \item{conv }{integer code: \code{0} indicates successful convergence. This parameter has the value of the output parameter \code{conv} from the procedure \code{\link{optimx}} used for likelihood maximization (see \code{\link{optimx}} for details).
  }
}
\references{
Plancade S., Rozenholc Y. and Lund E., Improving  background correction for Illumina BeadArrays: the normal-gamma model (http://arxiv.org/abs/1112.4180).


Xie Y. Wang X. and Story M. (2009), Statistical methods of background correction for Illumina BeadArray data, \emph{Bioinformatics},  \bold{25}(6), 751--757.
}
\author{
Plancade S. and Rozenholc Y.
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{


\code{\link{dnormgam}} computes the density of the normal-gamma distribution and \code{\link{normgam.signal}} implements the background correction using the normal-gamma model. \code{\link{Intensities}} provides an example of Illumina microarray data.


}
\examples{

# Example 1: simulated data

\dontrun{

n = 1000
par = c(60,5,0.15,400)
X = rnorm(n, mean=par[1], sd=par[2]) + rgamma(n, shape=par[3], scale=par[4]) 
N = rnorm(100, mean=par[1], sd=par[2])

par1 = normgam.fit(X, N)$par
par2 = normgam.fit(X)$par


F1 = dnormgam(par1, plot=FALSE)
F2 = dnormgam(par2, plot=FALSE)

par(mfrow=c(2,1))

H = histogram(X, type='irregular', verbose=FALSE, plot=FALSE)

plot(H, xlim=c(0,500))
lines(F1$xout, F1$dout,col='red')

plot(H, xlim=c(0,500))
lines(F2$xout, F2$dout,col='blue')
}

# Example 2: Illumina data

\dontrun{

data(RegNegIntensities_Example)
 
X = Intensities$Regular
N = Intensities$Negative

par1 = normgam.fit(X, N)$par
par2 = normgam.fit(X)$par

F1 = dnormgam(par1, plot=FALSE)
F2 = dnormgam(par2, plot=FALSE)

par(mfrow=c(2,1))

H = histogram(X, type='irregular', verbose=FALSE, plot=FALSE)

plot(H, xlim=c(0,500))
lines(F1$xout, F1$dout, col='red')

plot(H, xlim=c(0,500))
lines(F2$xout, F2$dout, col='blue')
}

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{normal }
\keyword{gamma}
\keyword{maximum likelihood}% __ONLY ONE__ keyword per line
