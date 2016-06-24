## Tutorial 'Small Area Estimation with R'

### Virgilio Gómez Rubio (Universidad de Castilla-La Mancha, Spain)


## Background

[Small Area Estimation](https://en.wikipedia.org/wiki/Small_area_estimation)
deals with the problem of providing estimates of some parameters of interest
for sub-populations. These techniques are often required when data from a
larger survey are available but parameter estimates are required at a smaller
level.  Typical problems include the estimation of income per household or
unemployment in sub-populations from survey data.

This is an important topic that has not been widely covered in previous useR!
conferences. Furthermore, there is a shortage of training materials on Small
Area Estimation with R.  This tutorial aims at providing an updated version of
the tutorial presented at useR! 2008 by including new R packages in the
'Official Statistics and Survey Methodology' Task View.


## Tutorial Overview

The tutorial will introduce different types of statistical methods for the
analysis of survey data to produce estimates for small domains (sometimes
termed 'small areas'). This will include design-based estimators, that are only
based on the study design and observed data, and model-based estimators, that
rely on an underlying model to provide estimates. The tutorial
will cover frequentist and Bayesian inference for Small Area Estimation.
All methods will be accompanied by several examples that attendants will be able
to reproduce.

This tutorial will be roughly based on the [tutorial presented at useR! 2008](http://www.bias-project.org.uk/SAE_tutorial/)
but will include updated materials. In particular, it will cover new R packages
that have appeared since then.

All tutorial materials will be available from a [Github repository](https://github.com/becarioprecario/SAERTutorial).

## Detailed Outline

The tutorial will use some case studies to present the main statistical
methods in Small Area Estimation. This includes:

1. Short introduction to survey sampling strategies with R: simple random
sampling, systematic sampling, clustered sampling, two-stage sampling
2. Design based-estimators: Horvitz-Thompson, generalized regression (GREG) and calibration estimators
3. Model-based estimators: Fay-Herriott estimator, linear regression for
area and unit level models
5. Synthetic and composite estimators
6. Mixed-effects models: area and unit level models with random effects, EBLUP estimators
7. Models with spatial random effects: spatial EBLUP for area and unit level models
8. Bayesian inference for Small Area Estimation: area and unit level models
9. Non-linear models: disease mapping, estimation of unemployment



## Background Knowledge

General knowledge on survey data analysis and mixed-effects
models would be useful. Attendants are assumed to be R users.

## Potential Attendees


This tutorial may be of interest to practitioners and researchers at national
offices for statistics, universities and research institutions working
on Small Area Estimation.


##Other software

###WinBUGS

WinBUGS is required to run some of the models presented in the tutorial.
You can download from [here](http://www.mrc-bsu.cam.ac.uk/software/bugs/) (read very carefully the instructions to install it).


###INLA

R-INLA is also required for some of the models. You can download it from [here](http://www.r-inla.org/download).
