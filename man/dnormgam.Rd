\name{dnormgam}
\alias{dnormgam}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Normal-gamma density
}
\description{
Computes the convolution product of a normal and a gamma densities.
}
\usage{
dnormgam(par, x = NULL, N0 = 65536, plot = TRUE, 
         log = FALSE, tail.cor = TRUE, cor = 1e-15,                                                                                                          
         mu = par[1], sigma = par[2], k = par[3], theta = par[4])                                                               
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{par}{
vector of parameters; \code{(par[1],par[2])} are the mean and standard deviation of the normal distribution and \code{(par[3],par[4])} are the shape and scale parameters of the gamma distribution.

}
\item{x}{
vector of values where the density is computed; if \code{x == NULL}, the density is computed on a sequence of values from \code{0} to \code{par[1]+5*par[2]+q} where \code{q} is the quantile of probability \code{0.99999} of the gamma distribution.

}
  \item{N0}{
number of equally spaced values in the Fast Fourier Transform (see details).
}
  \item{plot}{
logical; if \code{TRUE} plot of the density.

}
  \item{log}{
 logical; if \code{TRUE} density \code{d} is given as \code{log(d)}.
}
  \item{tail.cor}{
 logical; if \code{TRUE} a linear approximation of right tail adjusts numerical instability.
}
  \item{cor}{
limit of right tail correction; if \code{tail.cor == TRUE}, linear approximation is applied to values with density estimate smaller than \code{cor}.
}


 \item{mu, sigma}{
 alternative definition of mean and standard deviation of the normal distribution.}
 
 \item{k, theta}{
 alternative definition of shape and scale parameters of the gamma distribution.}

 

 }
\details{
The convoluted density is computed using the \code{fft} function (Fast Fourier Transform). See details in Plancade S., Rozenholc Y. and Lund E. (http://arxiv.org/abs/1112.4180).

Only one definition of the parameters is required, either  \code{par} or \code{(mu, sigma, k, theta)}. If both are specified and do not match, an error message is returned.


%Assume that we observe X = S+B where S is the signal with gamma distribution of shape k %and scale theta, B is the noise with normal distribution of mean mu and standard deviation sd, %and B and S are independent. dnormgam(mu, sigma, k, theta, x ) returns the density of X at x. 
 
 %%The normal-gamma density with parameters (\eqn{\mu},  \eqn{\sigma}, k, \eqn{\theta})  at \eqn{x} is the convolution %%product of \eqn{ exp(-\frac{(x-t- \mu)^2}{2\sigma ^2  }) }
 
%% \deqn{  \int \frac{1}{\sqrt{2\pi} \sigma} \frac{1}{\theta ^k \Gamma (k)}  \exp \left( - \frac{(x-t- \mu)^2}{2\sigma ^2 } 
%%\right)\cdot t^k \exp \left( - \frac{x}{\theta} \right) dt }

}
\value{
 \item{xout }{vector of values where normal-gamma density is computed; equal to \code{x} when \code{x} is not \code{NULL}.}
   \item{dout   }{vector of values of normal-gamma density.}
}
\references{
Plancade S., Rozenholc Y. and Lund E., Improving  background correction for Illumina BeadArrays: the normal-gamma model 
(http://arxiv.org/abs/1112.4180).
}
\author{
Plancade S. and Rozenholc Y.
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{normgam.fit}} computes the Maximum Likelihood Estimator and \code{\link{normgam.signal}} implements the background correction using the normal-gamma model.
}
\examples{

## Example 1

par = c(-10, 5, 2, 20)
F = dnormgam(par)

## Example 2 

n = 50000
par = c(60,5,0.15,400)
F = dnormgam(par, plot=FALSE)

X = rnorm(n, mean=par[1], sd=par[2]) + rgamma(n, shape=par[3], scale=par[4]) 
H = histogram(X, type='irregular', verbose=FALSE, plot=FALSE)
plot(H, xlim=c(0,500))
lines(F$xout, F$dout, col='red')

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{normal}
\keyword{gamma}
\keyword{convolution}
\keyword{density}
% __ONLY ONE__ keyword per line
