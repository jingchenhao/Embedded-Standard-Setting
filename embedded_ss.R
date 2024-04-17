library(openxlsx)
library("readxl")
data_dir=paste('/Users/jing.chen/OneDrive - Northwest Evaluation Association/',
               'Documents/NWEA/NCME_2021/standard_setting_criteria/', sep='')
#X<-read_excel(paste(data_dir,"generated.xlsx",sep=''))
x1<-c(rep(1,200),rep(2,600),rep(3,200))

n     <- 1000                 # length of vector
rho   <- 0.6                   # desired correlation = cos(angle)
theta <- acos(rho)             # corresponding angle
#x1    <- rnorm(n, 1, 1)        # fixed given data
x2    <- rnorm(n, 0, 5)      # new random data
X     <- cbind(x1, x2)         # matrix


Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)

Id   <- diag(n)                               # identity matrix
Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1

x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
cor(x1, x)                                    # check correlation = rho
aa=as.data.frame(cbind(x1,x))
write.xlsx(aa, file = paste(data_dir,"r_0.6.xlsx",sep=''),append = TRUE)
std(x)


getBiCop <- function(n, rho, mar.fun=rnorm, x = NULL, ...) {
  if (!is.null(x)) {X1 <- x} else {X1 <- mar.fun(n, ...)}
  if (!is.null(x) & length(x) != n) warning("Variable x does not have the same length as n!")
  
  C <- matrix(rho, nrow = 2, ncol = 2)
  diag(C) <- 1
  
  C <- chol(C)
  
  X2 <- mar.fun(n)
  X <- cbind(X1,X2)
  
  # induce correlation (does not change X1)
  df <- X %*% C
  
  ## if desired: check results
  #all.equal(X1,X[,1])
  #cor(X)
  
  return(df)
}
getBiCop(100,0.6)
cor(getBiCop(100,0.6)[,1],getBiCop(100,0.6)[,2])
