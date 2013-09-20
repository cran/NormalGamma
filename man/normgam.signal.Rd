\name{normgam.signal}
\alias{normgam.signal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Normal-gamma background correction
}
\description{
Performs background correction using the normal-gamma model.
}
\usage{
normgam.signal(x, par, tail.cor = TRUE, cor = 1e-15, gshift = FALSE, 
               mu = par[1], sigma = par[2], k = par[3], theta = par[4])
}

\arguments{
  \item{x}{
vector of observed intensities.
}
  \item{par}{
vector of parameters; \code{par[1]} and \code{par[2]} are the mean and standard deviation of the normal distribution and \code{par[3]} and \code{par[4]} are the shape and scale parameters of the gamma distribution. 
}
  \item{tail.cor}{
logical (see details).
}
  \item{cor}{
limit of the right tail correction (see details).
}
  \item{gshift}{
logical; if \code{TRUE} and \code{par[3]} is smaller than 1, an ad-hoc translation and a thresholding to 0 are applied to background-corrected values so that the mode of corrected value distribution is 0.
}
  \item{mu, sigma}{alternative definition of mean and standard deviation of the normal distribution.}
 
 \item{k, theta}{alternative definition of shape and scale parameters of the gamma distribution.}


 }
\details{
\code{normgam.signal} performs background correction in an additive background noise+signal model with a normal background noise and a gamma-distributed signal. The corrected value from an observed intensity \code{x} is the expectation of the signal given the signal and noise distributions. For a set of parameters \code{(mu, sigma, k, theta)}, it is given by the ratio of the convolution product of  \code{\link{dgamma}(x, shape=k+1, scale=theta)}  and \code{\link{dnorm}(x, mean=mu, sd=sigma)} and the convolution product of  \code{\link{dgamma}(x, shape=k, scale=theta)}  and \code{\link{dnorm}(x, mean=mu, sd=sigma)}. For more details see Plancade S., Rozenholc Y. and Lund E., BMC Bioinfo 2012.


If \code{tail.cor = TRUE}, a linear approximation of right tail is applied to values with density estimate smaller than \code{cor} in the computation of normal-gamma convoluted densities (see \code{\link{dnormgam}}).

Only one definition of the parameters is required, either  \code{par} or \code{(mu, sigma, k, theta)}. If both are specified and do not match, an error message is returned.

}
\value{
Vector of background noise-corrected intensities.
}
\references{
Plancade S., Rozenholc Y. and Lund E. "Generalization of the normal-exponential model : exploration of a more accurate parametrisation for the signal distribution on Illumina BeadArrays", BMC Bioinfo 2012, 13(329).
}
\author{
Plancade S. and Rozenholc Y.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 \code{\link{dnormgam}} computes the density of the normal-gamma distribution and \code{\link{normgam.fit}} computes the Maximum Likelihood Estimator. \code{\link{Intensities}} provides an example of Illumina microarray data.

}
\examples{

#Example 1: simulated data

n = 50000
par = c(60,5,0.15,400)
S = rgamma(n, shape=par[3], scale=par[4])
B = rnorm(n, mean=par[1], sd=par[2]) 
X = S + B

par(mfrow=c(2,1))

Shat1 = normgam.signal(X, par)
H1 = histogram(Shat1, type='irregular', verbose=FALSE, plot=FALSE)
plot(H1, xlim=c(0,50))
I = seq(from=0, to=50, length=1000)
lines(I, dgamma(I, shape=0.15, scale=400), col='red')

Shat2 = normgam.signal(X, par, gshift = TRUE)
H2 = hist(Shat2, 10000, plot=FALSE)
plot(H2, xlim=c(0,50), freq=FALSE)
lines(I, dgamma(I, shape=0.15, scale=400), col='red')


#Example 2: Illumina data

\dontrun{

data(RegNegIntensities_Example)

X = Intensities$Regular
N = Intensities$Negative

# parameter estimation
parmle = normgam.fit(X, N)$par 

Shat = normgam.signal(X,parmle)
H = histogram(Shat, type='irregular', verbose=FALSE, plot=FALSE)
plot(H, xlim=c(0,30))
}

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ normal }
\keyword{ gamma }
\keyword{convolution}
\keyword{ background correction}% __ONLY ONE__ keyword per line
