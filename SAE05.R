### R code from vignette source 'SAE05.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: SAE05.Rnw:340-344
###################################################
library(R2WinBUGS)
library(coda)

load("IncomeMCMC.RData")


###################################################
### code chunk number 2: SAE05.Rnw:353-371 (eval = FALSE)
###################################################
## library(R2WinBUGS)
## 
## areamodel<-paste(getwd(), "/Income/models/area_model.txt", sep="")
## dataarea<-source("Income/WBdata/area_data.txt")$value
## initsarea1<-source("Income/area_inits/inits-1.txt")$value
## initsarea2<-source("Income/area_inits/inits-2.txt")$value
## 
## wdir<-paste(getwd(), "/Income_area", sep="")
## if(!file.exists(wdir)){dir.create(wdir)}
## 
## BugsDir <- "/home/asdar/.wine/dosdevices/c:/Program Files/WinBUGS14"
## areares<- bugs(data=dataarea, inits=list(initsarea1, initsarea2),
##    working.directory=wdir,
##    parameters.to.save=c("mu", "sigmau", "u", "alpha", "bedterhh"),
##    n.chains=2, n.iter=3000, n.burnin=2000, n.thin=1,
##    model.file=areamodel,
##    bugs.directory=BugsDir,
##    WINEPATH="/usr/bin/winepath")


###################################################
### code chunk number 3: SAE05.Rnw:378-386 (eval = FALSE)
###################################################
## #Test spatial EBLUP with this data set
## library(spdep)
## library(SAE2)
## 
## nbmuni<-poly2nb(swmap2)
## W<-nb2mat(nbmuni, style="W", zero.policy=TRUE)
## d<-data.frame(Y=dataarea$Y, COV=dataarea$HHPERS, DESVAR=dataarea$desvar)
## SEBLUP(Y~COV, ~DESVAR, data=d, W=W)


###################################################
### code chunk number 4: SAE05.Rnw:395-412 (eval = FALSE)
###################################################
## unitmodel<-paste(getwd(), "/Income/models/unit_model.txt", sep="")
## dataunit<-source("Income/WBdata/unit_data.txt")$value
## initsunit1<-source("Income/unit_inits/inits-1.txt")$value
## initsunit2<-source("Income/unit_inits/inits-2.txt")$value
## 
## wdir<-paste(getwd(), "/Income_unit", sep="")
## if(!file.exists(wdir)){dir.create(wdir)}
## 
## BugsDir <- "/home/asdar/.wine/dosdevices/c:/Program Files/WinBUGS14"
## unitres<- bugs(data=dataunit, inits=list(initsunit1, initsunit2),
##    working.directory=wdir,
##    parameters.to.save=c("mug", "sigmau", "u", "alpha", "bedterhh", "sigmae"),
##    n.chains=2, n.iter=3000, n.burnin=2000, n.thin=1,
##    model.file=unitmodel,
##    bugs.directory=BugsDir,
##    WINEPATH="/usr/bin/winepath")
## 


###################################################
### code chunk number 5: codaarea (eval = FALSE)
###################################################
## library(coda)
## 
## chain1<-read.coda("Income_area/coda1.txt", "Income_area/codaIndex.txt")
## chain2<-read.coda("Income_area/coda2.txt", "Income_area/codaIndex.txt")
## chains<-mcmc.list(chain1, chain2)
## 
## plot(chains[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 6: SAE05.Rnw:434-435
###################################################
plot(chains[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 7: SAE05.Rnw:447-448 (eval = FALSE)
###################################################
## library(coda)
## 
## chain1<-read.coda("Income_area/coda1.txt", "Income_area/codaIndex.txt")
## chain2<-read.coda("Income_area/coda2.txt", "Income_area/codaIndex.txt")
## chains<-mcmc.list(chain1, chain2)
## 
## plot(chains[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 8: SAE05.Rnw:494-498
###################################################
library(R2WinBUGS)
library(coda)

load("IncomeMCMCspatial.RData")


###################################################
### code chunk number 9: SAE05.Rnw:507-527 (eval = FALSE)
###################################################
## library(R2WinBUGS)
## 
## areamodelsp<-paste(getwd(), "/Income/models/area_modelsp.txt", sep="")
## dataareasp<-source("Income/WBdata/area_datasp.txt")$value
## neighbours<-source("Income/WBdata/spdata.txt")$value
## initsareasp1<-source("Income/area_inits/initssp-1.txt")$value
## initsareasp2<-source("Income/area_inits/initssp-2.txt")$value
## 
## wdir<-paste(getwd(), "/Income_areasp", sep="")
## if(!file.exists(wdir)){dir.create(wdir)}
## 
## BugsDir <- "/home/asdar/.wine/dosdevices/c:/Program Files/WinBUGS14"
## arearessp<- bugs(data=c(dataareasp, neighbours), 
##    inits=list(initsareasp1, initsareasp2),
##    working.directory=wdir,
##    parameters.to.save=c("mu","sigmau", "u", "sigmav", "v", "alpha", "bedterhh"),
##    n.chains=2, n.iter=3000, n.burnin=2000, n.thin=1,
##    model.file=areamodelsp,
##    bugs.directory=BugsDir,
##    WINEPATH="/usr/bin/winepath")


###################################################
### code chunk number 10: codaarea (eval = FALSE)
###################################################
## library(coda)
## 
## chainsp1<-read.coda("Income_areasp/coda1.txt", "Income_areasp/codaIndex.txt")
## chainsp2<-read.coda("Income_areasp/coda2.txt", "Income_areasp/codaIndex.txt")
## chainssp<-mcmc.list(chainsp1, chainsp2)
## 
## plot(chainssp[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 11: SAE05.Rnw:548-549
###################################################
plot(chainssp[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 12: SAE05.Rnw:561-562 (eval = FALSE)
###################################################
## library(coda)
## 
## chainsp1<-read.coda("Income_areasp/coda1.txt", "Income_areasp/codaIndex.txt")
## chainsp2<-read.coda("Income_areasp/coda2.txt", "Income_areasp/codaIndex.txt")
## chainssp<-mcmc.list(chainsp1, chainsp2)
## 
## plot(chainssp[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 13: SAE05.Rnw:606-610
###################################################
library(R2WinBUGS)
library(coda)

load("IncomeMCMCregional.RData")


###################################################
### code chunk number 14: SAE05.Rnw:619-639 (eval = FALSE)
###################################################
## library(R2WinBUGS)
## 
## regionmodel<-paste(getwd(), "/Income/models-m/area_modelregion.txt", sep="")
## dataregion<-source("Income/WBdata-m/area_regiondata.txt")$value
## regneighbours<-source("Income/WBdata-m/spregiondata.txt")$value
## initsregion1<-source("Income/area_inits-m/initsregion-1.txt")$value
## initsregion2<-source("Income/area_inits-m/initsregion-2.txt")$value
## 
## wdir<-paste(getwd(), "/Income_region", sep="")
## if(!file.exists(wdir)){dir.create(wdir)}
## 
## BugsDir <- "/home/asdar/.wine/dosdevices/c:/Program Files/WinBUGS14"
## regionres<- bugs(data=c(dataregion, regneighbours),
##    inits=list(initsregion1, initsregion2),
##    working.directory=wdir,
##    parameters.to.save=c("mu","sigmau", "u", "sigmaregion.v", "r", "alpha", "bedterhh"),
##    n.chains=2, n.iter=3000, n.burnin=2000, n.thin=1,
##    model.file=regionmodel,
##    bugs.directory=BugsDir,
##    WINEPATH="/usr/bin/winepath")


###################################################
### code chunk number 15: codaarea (eval = FALSE)
###################################################
## library(coda)
## 
## chainreg1<-read.coda("Income_region/coda1.txt", "Income_region/codaIndex.txt")
## chainreg2<-read.coda("Income_region/coda2.txt", "Income_region/codaIndex.txt")
## chainsreg<-mcmc.list(chainreg1, chainreg2)
## 
## plot(chainsreg[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 16: SAE05.Rnw:660-661
###################################################
plot(chainssp[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 17: SAE05.Rnw:673-674 (eval = FALSE)
###################################################
## library(coda)
## 
## chainreg1<-read.coda("Income_region/coda1.txt", "Income_region/codaIndex.txt")
## chainreg2<-read.coda("Income_region/coda2.txt", "Income_region/codaIndex.txt")
## chainsreg<-mcmc.list(chainreg1, chainreg2)
## 
## plot(chainsreg[, c("deviance", "alpha", "mu[1]")])


###################################################
### code chunk number 18: SAE05.Rnw:753-760
###################################################
bayesres<-data.frame(AEMSE=c(NA, NA), 
  DIC=c(areares$DIC, arearessp$DIC))

bayesres$AEMSE[1]<-mean((areares$mean$mu-0)^2)
bayesres$AEMSE[2]<-mean((arearessp$mean$mu-0)^2)

bayesres


