### R code from vignette source 'SAE02.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: SAE02.Rnw:262-269 (eval = FALSE)
###################################################
## library(sampling)
## data(MU284)
## 
## MU284 <- MU284[order(MU284$REG), ]
## MU284$LABEL <- 1:284
## 
## summary(MU284)


###################################################
### code chunk number 2: SAE02.Rnw:272-277
###################################################
library(sampling)
data(MU284)

MU284 <- MU284[order(MU284$REG), ]
MU284$LABEL <- 1:284


###################################################
### code chunk number 3: SAE02.Rnw:303-317
###################################################
library(maptools)
swmap <- readShapePoly("Sweden_municipality")#, ID="KOD83_91")
#summary(swmap$"KOD83_91")

library(maptools)
swmap2 <- unionSpatialPolygons(swmap, swmap$"KOD83_91")
swmap2 <- SpatialPolygonsDataFrame(swmap2, 
  data.frame(REG = as.factor(MU284$REG)),
   match.ID = FALSE)

#Regions of Sweden
swreg <- unionSpatialPolygons(swmap2, swmap2$REG)
swreg <- SpatialPolygonsDataFrame(swreg, 
  data.frame(REG = as.factor(1:8)), match.ID = FALSE)


###################################################
### code chunk number 4: SAE02.Rnw:320-324
###################################################
library(RColorBrewer)
cols<-brewer.pal(8, "Pastel1")

print(spplot(swreg, "REG", col.regions = cols))


###################################################
### code chunk number 5: SAE02.Rnw:330-336
###################################################
#Neighbours
library(spdep)

nb <- poly2nb(swreg)
W <- nb2mat(nb, style = "B")



###################################################
### code chunk number 6: SAE02.Rnw:354-365
###################################################
#Select a few areas (Estimation of the national revenues)
N <- 284 #Total number of municipalities
n <- 32    #~1% Sample size
nreg <- length(unique(MU284$REG))

#Simple random sampling without replacement
set.seed(1)
smp <- srswor(n, N)
dsmp <- MU284[smp == 1, ]

table(dsmp$REG)


###################################################
### code chunk number 7: SAE02.Rnw:385-394
###################################################
#Multi-stage random sampling
set.seed(1)
smpcl <- mstage(MU284, stage = list("cluster", "cluster"),
   varnames = list("REG", "LABEL"),
   size = list(8, rep(4, 8)), method = c("srswor", "srswor") )

dsmpcl <- MU284[smpcl[[2]]$LABEL, ]

table(dsmpcl$REG)


###################################################
### code chunk number 8: SAE02.Rnw:421-430
###################################################
#Multi-stage random sampling WITH MISSING AREAS
set.seed(1)
smpcl2 <- mstage(MU284, stage = list("cluster", "cluster"),
   varnames = list("REG", "LABEL"),
   size = list(4, rep(8, 8)), method = c("srswor", "srswor") )

dsmpcl2 <- MU284[smpcl2[[2]]$LABEL, ]

table(dsmpcl2$REG)


###################################################
### code chunk number 9: SAE02.Rnw:444-457
###################################################
#plot(MU284$LABEL, MU284$RMT85)
plot(dsmp$LABEL, dsmp$RMT85, pch = 19, xlab = "MUNICIPALITY", ylab = "RMT85" )
points(dsmpcl$LABEL - .25, dsmpcl$RMT85, pch = 19, col = "red")
points(dsmpcl2$LABEL + .25, dsmpcl2$RMT85, pch = 19, col = "lightblue")
#abline(h=mean(MU284$RMT85))

lreg <- as.numeric(by(MU284$REG, MU284$REG,length))
for(i in 1:7)
        abline(v = sum(lreg[1:i]), lty = 2)

legend(150, 800, c("SRSWOR", "CLSWOR", "CLSWOR2"), pch = rep(19, 3),
   col = c("black", "red", "lightblue"))



###################################################
### code chunk number 10: SAE02.Rnw:486-495
###################################################
library(survey)
RMT85 <- mean(MU284$RMT85)
RMT85REG <- as.numeric(by(MU284$RMT85, MU284$REG, mean))

#       dest<-sum(dsmp$RMT85/(n/N))

#       destcl<-sum(dsmpcl$RMT85/smpcl[[2]]$Prob)

#       destcl2<-sum(dsmpcl2$RMT85/smpcl2[[2]]$Prob)


###################################################
### code chunk number 11: SAE02.Rnw:507-511
###################################################

svy <- svydesign(~ 1, data = dsmp, fpc = rep(284, n))
dest <- svymean(~ RMT85, svy, deff = TRUE)
#destvar<-svyvar(~RMT85, svy)


###################################################
### code chunk number 12: SAE02.Rnw:518-523
###################################################
fpc <- lreg[dsmpcl$REG]

svycl <- svydesign(id = ~ 1, strata = ~ REG, data = dsmpcl, fpc = fpc)
destcl <- svymean(~ RMT85, svycl, deff = TRUE)
#destclvar<-svyvar(~RMT85, svycl)


###################################################
### code chunk number 13: SAE02.Rnw:530-536
###################################################
fpc2 <- lreg[dsmpcl2$REG]
svycl2 <- svydesign(id = ~ 1, strata = ~ REG, data = dsmpcl2, 
   fpc = fpc2)
destcl2 <- svymean(~ RMT85, svycl2, deff = TRUE)
#destcl2var<-svyvar(~RMT85, svycl2)



###################################################
### code chunk number 14: SAE02.Rnw:554-558
###################################################
#Estimation of domains
destdom <- svyby( ~ RMT85,  ~ REG, svy, svymean)
#destdomvar<-svyby(~RMT85, ~REG, svy, svyvar)
destdom


###################################################
### code chunk number 15: SAE02.Rnw:575-578
###################################################
destdomcl <- svyby(~ RMT85, ~ REG, svycl, svymean)
#destdomclvar<-svyby(~RMT85, ~REG, svycl, svyvar)
destdomcl


###################################################
### code chunk number 16: SAE02.Rnw:597-600
###################################################
destdomcl2 <- svyby(~ RMT85, ~ REG, svycl2, svymean)
#destdomcl2var<-svyby(~RMT85, ~REG, svycl2, svyvar)
destdomcl2


###################################################
### code chunk number 17: SAE02.Rnw:663-678
###################################################

pop.totals = c(`(Intercept)` = N, ME84 = sum(MU284$ME84))

svygreg<-calibrate(svy, ~ ME84, calfun = "linear",
   population = pop.totals )
svymean(~ RMT85, svygreg)

svygregcl <- calibrate(svycl, ~ ME84, calfun = "linear",
   population = pop.totals )
svymean(~ RMT85, svygregcl)

svygregcl2 <- calibrate(svycl2, ~ ME84, calfun = "linear",
   population = pop.totals )
svymean(~ RMT85, svygregcl2)



###################################################
### code chunk number 18: SAE02.Rnw:776-789
###################################################

results <- data.frame(AEMSE = rep(NA, 3), DEFF = rep(NA, 3))
rownames(results) <- c("NAT. SRS", "NAT. CL", "NAT. CL2")

#Total RMT85
results$AEMSE[1] <- (dest[1]-RMT85)^2
results$DEFF[1] <- deff(dest)
results$AEMSE[2] <- (destcl[1]-RMT85)^2
results$DEFF[2] <- deff(destcl)
results$AEMSE[3] <- (destcl2[1]-RMT85)^2
results$DEFF[3] <- deff(destcl2)

results


###################################################
### code chunk number 19: SAE02.Rnw:795-804
###################################################
plot(RMT85REG, destdom[,2], pch = 19, xlab = "True RMT85",
  ylab = "Estimated RMT85",
  ylim = range(c(destdom[,2], destdomcl[,2], destdomcl2[,2])) )
abline(0, 1)
points(RMT85REG, destdomcl[, 2], pch = 19, col = "red")
points(RMT85REG[destdomcl2$REG], destdomcl2[, 2], pch = 19, col = "lightblue")

legend(400, 1000, c("SRSWOR", "CLSWOR", "CLSWOR2"), pch = rep(19, 3),
   col = c("black", "red", "lightblue")) 


###################################################
### code chunk number 20: SAE02.Rnw:815-816
###################################################
save(file = "SAE02.RData", list = ls())


