\name{neuralnet-package}
\alias{neuralnet-package}
\docType{package}
\title{
Training of neural networks
}
\description{
Training of neural networks using the backpropagation, resilient backpropagation with (Riedmiller, 1994) or without weight backtracking (Riedmiller, 1993) or the modified globally convergent version by Anastasiadis et al. (2005). The package allows flexible settings through custom-choice of error and activation function. Furthermore, the calculation of generalized weights (Intrator O & Intrator N, 1993) is implemented.
}
\details{
\tabular{ll}{
Package: \tab neuralnet\cr
Type: \tab Package\cr
Version: \tab 1.32\cr
Date: \tab 2012-09-19\cr
License: \tab GPL (>=2)
}

}
\author{
Stefan Fritsch, 
Frauke Guenther \email{guenther@bips.uni-bremen.de}, 
following earlier work by Marc Suling

Maintainer: Frauke Guenther \email{guenther@bips.uni-bremen.de}
}
\references{ 
    Riedmiller M. (1994) 
    \emph{Rprop - Description and Implementation Details.}
    Technical Report. University of Karlsruhe.

    Riedmiller M. and Braun H. (1993) 
    \emph{A direct adaptive method for faster backpropagation learning: The RPROP algorithm.}
    Proceedings of the IEEE International Conference on Neural Networks (ICNN), pages 586-591.
    San Francisco.

    Anastasiadis A. et. al. (2005) 
    \emph{New globally convergent training scheme based on the resilient propagation algorithm.} 
    Neurocomputing 64, pages 253-270. 

    Intrator O. and Intrator N. (1993)
    \emph{Using Neural Nets for Interpretation of Nonlinear Models.}  
    Proceedings of the Statistical Computing Section, 244-249 
    San Francisco: American Statistical Society (eds). 
}
\note{
  This work has been supported by the German Research Foundation\cr
  (DFG: \url{http://www.dfg.de})
  under grant scheme PI 345/3-1.
}
\keyword{ neural }
\seealso{
 \code{\link{plot.nn}} for plotting of the neural network.

 \code{\link{gwplot}} for plotting of the generalized weights.

 \code{\link{compute}} for computation of the calculated network.

 \code{\link{confidence.interval}} for calculation of a confidence interval for the weights.

 \code{\link{prediction}} for calculation of a prediction.
}
\examples{
AND <- c(rep(0,7),1)
OR <- c(0,rep(1,7))
binary.data <- data.frame(expand.grid(c(0,1), c(0,1), c(0,1)), AND, OR)
print(net <- neuralnet(AND+OR~Var1+Var2+Var3,  binary.data, hidden=0, 
             rep=10, err.fct="ce", linear.output=FALSE))

XOR <- c(0,1,1,0)
xor.data <- data.frame(expand.grid(c(0,1), c(0,1)), XOR)
print(net.xor <- neuralnet(XOR~Var1+Var2, xor.data, hidden=2, rep=5))
plot(net.xor, rep="best")

data(infert, package="datasets")
print(net.infert <- neuralnet(case~parity+induced+spontaneous,  infert, 
                    err.fct="ce", linear.output=FALSE, likelihood=TRUE))
gwplot(net.infert, selected.covariate="parity")
gwplot(net.infert, selected.covariate="induced")
gwplot(net.infert, selected.covariate="spontaneous")
confidence.interval(net.infert)

Var1 <- runif(50, 0, 100) 
sqrt.data <- data.frame(Var1, Sqrt=sqrt(Var1))
print(net.sqrt <- neuralnet(Sqrt~Var1, sqrt.data, hidden=10, 
                  threshold=0.01))
compute(net.sqrt, (1:10)^2)$net.result

Var1 <- rpois(100,0.5)
Var2 <- rbinom(100,2,0.6)
Var3 <- rbinom(100,1,0.5)
SUM <- as.integer(abs(Var1+Var2+Var3+(rnorm(100))))
sum.data <- data.frame(Var1+Var2+Var3, SUM)
print(net.sum <- neuralnet(SUM~Var1+Var2+Var3, sum.data, hidden=1, 
                 act.fct="tanh"))
prediction(net.sum)
}
