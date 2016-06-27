### R code from vignette source 'SAE06.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: SAE06.Rnw:188-204
###################################################
library(maptools)
library(spdep)
library(rgdal)

#Read data from shapefile
nc <- readShapePoly(system.file("etc/shapes/sids.shp", 
  package = "spdep")[1],
  ID = "FIPSNO")
rn <- sapply(slot(nc, "polygons"), function(x) slot(x, "ID"))

#Adjacency matrix from Cressie and Chan (1989)
ncCC89nb <- read.gal(system.file("etc/weights/ncCC89.gal", 
  package = "spdep")[1], region.id = rn)

#Transform adj. matrix into the format required by WB
nc.nb <- nb2WB(ncCC89nb)


###################################################
### code chunk number 2: SAE06.Rnw:213-232
###################################################
#Prepare data set
nc$Observed <- nc$SID74
nc$Population <- nc$BIR74#Population at risk; number of births
r <- sum(nc$Observed) / sum(nc$Population)
nc$Expected <- nc$Population * r
N <- length(nc$Observed)

#Computed Standardised Mortality Ratio
nc$SMR <- nc$Observed / nc$Expected
#Proportion of non-white births
nc$nwprop <- nc$NWBIR74 / nc$BIR74

#Prepare data and initial values for WinBUGS
d <- list(N = N, observed = nc$Observed, expected = nc$Expected,
  nonwhite = nc$nwprop,#log(nwprop/(1-nwprop)),
  adj = nc.nb$adj,  weights = nc.nb$weights, num = nc.nb$num)

inits <- list(u = rep(0, N), v = rep(0, N), alpha = 0, beta = 0, 
  precu = .001, precv = .001)


###################################################
### code chunk number 3: SAE06.Rnw:240-262
###################################################
library(R2WinBUGS)

bymmodelfile<-paste(getwd(), "/BYM-model.txt", sep="")
wdir<-paste(getwd(), "/BYM", sep="")
if(!file.exists(wdir)){dir.create(wdir)}

BugsDir <-
   "/Users/virgil/.wine/dosdevices/c:/Program Files/WinBUGS14"
MCMCres<- bugs(data=d, inits=list(inits),
   working.directory=wdir,
   parameters.to.save=c("theta", "alpha", "beta", "u", "v",
     "sigmau", "sigmav"),
   n.chains=1, n.iter=30000, n.burnin=20000, n.thin=10,
   model.file=bymmodelfile, bugs.directory=BugsDir,
   WINEPATH="/usr/local/bin/winepath")


#Load the data obtained by running WinBUGS in Windows
nc$BYMmean<-MCMCres$mean$theta
nc$BYMumean<-MCMCres$mean$u
nc$BYMvmean<-NA
nc$BYMvmean[nc.nb$num>0]<-MCMCres$mean$v


###################################################
### code chunk number 4: coda (eval = FALSE)
###################################################
## library(coda)
## ncoutput <- read.coda("BYM/coda1.txt", "BYM/codaIndex.txt")
## 
## plot(ncoutput[,c("deviance", "beta")])


###################################################
### code chunk number 5: codaplot
###################################################
library(coda)
ncoutput <- read.coda("BYM/coda1.txt", "BYM/codaIndex.txt")

plot(ncoutput[,c("deviance", "beta")])


###################################################
### code chunk number 6: sidsplot
###################################################
library(RColorBrewer)
brks <- quantile(nc$SMR, seq(0, 1, 1/5))

#Used method proposed by Nicky Best
logSMR <- log(nc$SMR[nc$SMR > 0])
nsteps <- 5
step <- (max(logSMR) - min(logSMR)) / nsteps
brks <- exp(min(logSMR) + (0:nsteps) * step)
brks[1] <- 0

cols <- brewer.pal(5, "Oranges")

atcol <- (0:5) * max(nc$SMR)/5
key.labels <- as.character(c(formatC(brks, format = "f", dig = 2)))
colorkey <- list(labels = key.labels, at = atcol,  height = .5)

print(spplot(nc, c("SMR", "BYMmean"), at = brks, col.regions = cols,
  axes = TRUE, colorkey = colorkey))


###################################################
### code chunk number 7: SAE06.Rnw:319-320 (eval = FALSE)
###################################################
## library(RColorBrewer)
## brks <- quantile(nc$SMR, seq(0, 1, 1/5))
## 
## #Used method proposed by Nicky Best
## logSMR <- log(nc$SMR[nc$SMR > 0])
## nsteps <- 5
## step <- (max(logSMR) - min(logSMR)) / nsteps
## brks <- exp(min(logSMR) + (0:nsteps) * step)
## brks[1] <- 0
## 
## cols <- brewer.pal(5, "Oranges")
## 
## atcol <- (0:5) * max(nc$SMR)/5
## key.labels <- as.character(c(formatC(brks, format = "f", dig = 2)))
## colorkey <- list(labels = key.labels, at = atcol,  height = .5)
## 
## print(spplot(nc, c("SMR", "BYMmean"), at = brks, col.regions = cols,
##   axes = TRUE, colorkey = colorkey))


###################################################
### code chunk number 8: SAE06.Rnw:394-414 (eval = FALSE)
###################################################
## dunemp <- source("Unemployment/WBdata/datasp.txt")$value
## dsp <- source("Unemployment/WBdata/spdata.txt")$value
## 
## initsunemp1 <- source("Unemployment/inits/initssp-1.txt")$value
## initsunemp2 <- source("Unemployment/inits/initssp-2.txt")$value
## 
## bymmodelfile <- paste0(getwd(), "/Unemployment/models/modelsp.txt")
## wdir <- paste0(getwd(), "/BYM-Unemp")
## if(!file.exists(wdir)){dir.create(wdir)}
## 
## #BugsDir <-
## #  "/Users/virgiliogomezgislab/.wine/dosdevices/c:/Program Files/WinBUGS14"
## MCMCresunemp<- bugs(data = c(dunemp, dsp),
##    inits = list(initsunemp1, initsunemp2),
##    working.directory = wdir,
##    parameters.to.save = c("p", "alpha", "bage", "bsex", "beduc"),
##    n.chains = 2, n.iter = 3000, n.burnin = 2000, n.thin = 1,
##    model.file = bymmodelfile,
##    bugs.directory = BugsDir,
##    WINEPATH = "/usr/bin/winepath")


###################################################
### code chunk number 9: SAE06.Rnw:417-418
###################################################
load("MCMCresunemp.RData")


###################################################
### code chunk number 10: Sweden
###################################################
library(maptools)
Sweden <- readShapePoly(fn = "Sweden_municipality")
Sweden <- unionSpatialPolygons(Sweden, Sweden$KOD83_91)
Sweden <- SpatialPolygonsDataFrame(Sweden, 
   data.frame(unemp = 1 - unique(MCMCresunemp$mean$p)), 
   match.ID = FALSE )

print(spplot(Sweden, "unemp", cuts=20))


###################################################
### code chunk number 11: SAE06.Rnw:443-444 (eval = FALSE)
###################################################
## library(maptools)
## Sweden <- readShapePoly(fn = "Sweden_municipality")
## Sweden <- unionSpatialPolygons(Sweden, Sweden$KOD83_91)
## Sweden <- SpatialPolygonsDataFrame(Sweden, 
##    data.frame(unemp = 1 - unique(MCMCresunemp$mean$p)), 
##    match.ID = FALSE )
## 
## print(spplot(Sweden, "unemp", cuts=20))


