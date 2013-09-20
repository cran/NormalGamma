\name{Intensities}
\alias{Intensities}
\docType{data}
\title{
Regular and Negative probes from one Illumina microarray
}
\description{
Provides probe intensities measured on Illumina Human HT-6 v4 Expression BeadChip, from one control in the NOWAC cohort (for more details, see Plancade S., Rozenholc Y. and Lund E. BMC Bioinfo 2012). Vectors \code{Regular} and \code{Negative} contain the intensities of regular and negative probes, respectively.

}
\usage{data(RegNegIntensities_Example)}

\format{A list \code{Intensities} with two elements: a vector \code{Regular} of length 25 519 and a vector \code{Negative} of length 759.}

\references{
Plancade S., Rozenholc Y. and Lund E. "Generalization of the normal-exponential model : exploration of a more accurate parametrisation for the signal distribution on Illumina BeadArrays", BMC Bioinfo 2012, 13(329).

Lund, E., Dumeaux, V., Braaten T., Hjartaker A., Engeset D., Skeie G., and Kumle M. (2008), Cohort profile: the norwegian women and cancer -nowac- kvinner og kreft, \emph{Int. J. Epidemiol.}, \bold{37}(1), 36--41.


}
\examples{

data(RegNegIntensities_Example)
X = Intensities$Regular
N = Intensities$Negative

par(mfrow=c(2,1))

HX = histogram (X, type='irregular', verbose=FALSE, plot=FALSE)
plot(HX, xlim=c(0,500))
hist(N, 30)




}

\keyword{datasets}
