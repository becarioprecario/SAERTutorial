#
#Run this script to install the packages required in this tutorial
#

pkgs<-c("devtools", "coda", "gpclib",  
   "maptools", "Matrix", "nlme", "lme4","R2WinBUGS", "RColorBrewer", "rgdal",
   "sampling", "sp", "SparseM", "spdep", "survey", "tripack"
)


install.packages(pkgs)

#R-INLA
install.packages("INLA", repos="https://www.math.ntnu.no/inla/R/stable")

#SAE2
devtools::install_github("becarioprecario/SAE2")

