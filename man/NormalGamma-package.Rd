\name{NormalGamma-package}
\alias{NormalGamma-package}
\alias{NormalGamma}
\docType{package}
\title{

Background correction using the normal+gamma model
}
\description{
The \code{NormalGamma} package is devoted to the density convolution model Y = X + N where X and N are independent variables with respectively gamma and normal distributions. For this model called further normal-gamma convolution model, this package proposes the computation of the convoluted density, the parameter estimation by likelihood maximization and the background correction obtained by deconvolution.

This package has been used to implement the background correction method for Illumina microarray data presented in Plancade S., Rozenholc Y. and Lund E., BMC Bioinfo 2012. 

}
\details{
\tabular{ll}{
Package: \tab NormalGamma\cr
Type: \tab Package\cr
Version: \tab 001.0\cr
Date: \tab 2011-12-20\cr
License: \tab GPL-3\cr
}
The \code{NormalGamma} package includes three functions and a data set:

\code{\link{dnormgam}} computes the convolution product of a normal and a gamma densities. 

\code{\link{normgam.fit}} computes the Maximum Likelihood Estimator of the parameters. 

\code{\link{normgam.signal}} performs the normal-gamma background correction.

\code{\link{Intensities}} provides data from one Illumina microarray.

}
\author{
Plancade S. and Rozenholc Y. 
 


Maintainer: Plancade S. <Sandra.Plancade@jouy.inra.fr>

}
\references{
Plancade S., Rozenholc Y. and Lund E. "Generalization of the normal-exponential model : exploration of a more accurate parametrisation for the signal distribution on Illumina BeadArrays", BMC Bioinfo 2012, 13(329).

%~~ Literature or other references for background information ~~
}
%~~ Optionally other standard keywords, one per line, from file KEYWORDS in the ~~
%~~ R documentation directory ~~
\keyword{ package }

\examples{

# Load Illumina microarray data previously transformed into two sets of intensities
# corresponding to negative and regular probes.

\dontrun{

data(RegNegIntensities_Example)

X = Intensities$Regular
N = Intensities$Negative

## Compute the maximum likelihood estimator:
parmle = normgam.fit(X, N)$par

par(mfrow=c(2,1)) # split windows for post comparison

## plot the histogram and the estimated density:
F = dnormgam(parmle, plot=FALSE) 


H = histogram(X, type='irregular', verbose=FALSE, plot=FALSE) 
plot(H, xlim=c(0,500))
lines(F$xout, F$dout, col='red')

# Perform the normal-gamma background correction: 
Shat = normgam.signal(X,parmle)
H = histogram(Shat, type='irregular', verbose=FALSE, plot=FALSE) 
plot(H, xlim=c(0,30))

}




}
