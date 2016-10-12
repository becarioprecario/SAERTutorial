### R code from vignette source 'SAE04.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: SAE04.Rnw:262-263
###################################################
load(file="SAE03.RData")


###################################################
### code chunk number 2: SAE04.Rnw:267-273
###################################################
library(SAE2)
spam.options(eps=.0000001)

dmm<-cbind(data.frame(REG=1:8, DIREST=destdom$RMT85, 
   DESVAR=destdom$se^2), REGCOV)
dmmeblup<-EBLUP(DIREST~ME84, ~DESVAR, data=dmm )


###################################################
### code chunk number 3: SAE04.Rnw:277-278
###################################################
dmmeblup


###################################################
### code chunk number 4: unitmm
###################################################
library(nlme)

mm<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl)
unitmm<-predict(mm, dmm)


###################################################
### code chunk number 5: SAE04.Rnw:320-323
###################################################
plot(RMT85REG, unitmm)
abline(0,1)
library(nlme)

mm<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl)
unitmm<-predict(mm, dmm)


###################################################
### code chunk number 6: SAE04.Rnw:328-329 (eval = FALSE)
###################################################
## library(nlme)
## 
## mm<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl)
## unitmm<-predict(mm, dmm)


###################################################
### code chunk number 7: SAE04.Rnw:331-332
###################################################
mm


###################################################
### code chunk number 8: unitmm
###################################################
mmmiss<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl2)
unitmmmiss<-predict(mmmiss, dmm)
unitmmmiss[is.na(unitmmmiss)]<-predict(mmmiss, dmm, level=0)[is.na(unitmmmiss)]


###################################################
### code chunk number 9: SAE04.Rnw:369-372
###################################################
plot(RMT85REG, unitmmmiss)
abline(0,1)
mmmiss<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl2)
unitmmmiss<-predict(mmmiss, dmm)
unitmmmiss[is.na(unitmmmiss)]<-predict(mmmiss, dmm, level=0)[is.na(unitmmmiss)]


###################################################
### code chunk number 10: SAE04.Rnw:377-378 (eval = FALSE)
###################################################
## mmmiss<-lme(RMT85~ME84, random=~1|REG, data=dsmpcl2)
## unitmmmiss<-predict(mmmiss, dmm)
## unitmmmiss[is.na(unitmmmiss)]<-predict(mmmiss, dmm, level=0)[is.na(unitmmmiss)]


###################################################
### code chunk number 11: SAE04.Rnw:380-381
###################################################
mmmiss


###################################################
### code chunk number 12: SAE04.Rnw:465-469
###################################################
library(spdep)
regnb<-poly2nb(swreg)
W<-nb2mat(regnb, style="W")



###################################################
### code chunk number 13: SAE04.Rnw:472-474
###################################################
dmmseblup<-SEBLUP(DIREST~ME84, ~DESVAR, data=dmm , W=W, method="REML")
dmmseblup


