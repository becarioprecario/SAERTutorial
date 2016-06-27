### R code from vignette source 'SAE03.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: SAE03.Rnw:184-187
###################################################
#Load data and reload libraries
load(file="SAE02.RData")
library(survey)


###################################################
### code chunk number 2: lm (eval = FALSE)
###################################################
## survlm <- lm(RMT85 ~ ME84, dsmp)
## survglm <- svyglm(RMT85 ~ ME84, svy)
## plot(MU284$ME84, MU284$RMT85, xlab = "ME84",
##   ylab = "RMT85", xlim = c(0, 10000))


###################################################
### code chunk number 3: SAE03.Rnw:202-203
###################################################
survlm <- lm(RMT85 ~ ME84, dsmp)
survglm <- svyglm(RMT85 ~ ME84, svy)
plot(MU284$ME84, MU284$RMT85, xlab = "ME84",
  ylab = "RMT85", xlim = c(0, 10000))


###################################################
### code chunk number 4: SAE03.Rnw:209-210 (eval = FALSE)
###################################################
## survlm <- lm(RMT85 ~ ME84, dsmp)
## survglm <- svyglm(RMT85 ~ ME84, svy)
## plot(MU284$ME84, MU284$RMT85, xlab = "ME84",
##   ylab = "RMT85", xlim = c(0, 10000))


###################################################
### code chunk number 5: SAE03.Rnw:342-351
###################################################
library(nlme)

#Region level covariates
REGCOV <- data.frame(ME84 = as.vector(by(MU284$ME84, MU284$REG,mean)))

#One variance
gls1 <- gls(RMT85 ~ ME84, data = dsmp)

synth1 <- predict(gls1, REGCOV, interval = "confidence")


###################################################
### code chunk number 6: SAE03.Rnw:360-368
###################################################
#Region-level variances
#dsmp$REG<-as.factor(dsmp$REG)
l <- as.list(rep(1,7))
names(l) <- as.character(2:8)
vf1 <- varIdent(l, form = ~ 1 | REG)
gls2 <- gls(RMT85 ~ ME84, data = dsmp, weights = vf1)

synth2 <- predict(gls2, REGCOV, interval = "confidence")


###################################################
### code chunk number 7: SAE03.Rnw:409-413
###################################################
#One variance
glsmiss1 <- gls(RMT85 ~ ME84, data = dsmp)

synthmiss1 <- predict(glsmiss1, REGCOV, interval = "confidence")


###################################################
### code chunk number 8: SAE03.Rnw:421-430
###################################################
#Region-level variances
#dsmp$REG<-as.factor(dsmp$REG)
regs <- unique(dsmpcl2$REG)
l <- as.list(rep(1,length(regs) - 1))
names(l) <- as.character(regs[-1])
vfmiss1 <- varIdent(l, form = ~ 1 | REG)
glsmiss2 <- gls(RMT85 ~ ME84, data = dsmpcl2, weights = vfmiss1)

synthmiss2 <- predict(glsmiss2, REGCOV, interval = "confidence")


###################################################
### code chunk number 9: SAE03.Rnw:494-500
###################################################
gammaw1 <- 1 - (destdom$se^2)/((synth1 - destdom$RMT85)^2)
gammaw1
gammaw1[gammaw1 < 0] <- 0
gammaw1[gammaw1 > 1] <- 1
comp1 <- gammaw1 * destdom[, 2] + (1 - gammaw1) * synth1
comp1


###################################################
### code chunk number 10: SAE03.Rnw:508-512
###################################################
gammaw2 <- 1 - sum(destdom$se^2) / sum((synth2 - destdom$RMT85)^2)
gammaw2
comp2 <- gammaw2 * destdom[,2] + (1 - gammaw2) * synth2
comp2


###################################################
### code chunk number 11: SAE03.Rnw:521-532
###################################################
results<-data.frame(AEMSE=rep(NA, 5))
rownames(results)<-c("DIRECT", "SYNTH 1",
"SYNTH 2",  "COMP GAMMA_i", "COMP GAMMA")

results$AEMSE[1]<-mean((destdomcl[,2]-RMT85REG)^2)
results$AEMSE[2]<-mean((synth1-RMT85REG)^2)
results$AEMSE[3]<-mean((synth2-RMT85REG)^2)
results$AEMSE[4]<-mean((comp1-RMT85REG)^2)
results$AEMSE[5]<-mean((comp2-RMT85REG)^2)

results


###################################################
### code chunk number 12: SAE03.Rnw:556-557
###################################################
save(file="SAE03.RData", list=ls())


