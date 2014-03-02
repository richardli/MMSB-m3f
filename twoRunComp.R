source("~/Dropbox/Big-data-workspace/helperFunc.R")
####################################################
##
## First set of parameter
##
data = 'movielens100k'
numFacs = 20
KU = 5
KM = 1
distSeed = 0;
init = 3
numTopicFacs = 2
n.gibbs = 500
burnin = 300
distSeed = 0
model = 'tif'
#####################
# open one run's RMSE
source("~/Dropbox/Big-data-workspace/OneRunAna.R")
rmse1 <- rmse
item.var1 <- item.toplot
user.var1 <- user.toplot
#####################
###
###  change the corresponding parameter here
###
distSeed = 1
#####################
source("~/Dropbox/Big-data-workspace/OneRunAna.R")
rmse2 <- rmse
item.var2 <- item.toplot
user.var2 <- user.toplot
#####################
#
# plot difference against variance
#
#####################
tworunplot(item.var1, item.var2, "Movie", TRUE)
tworunplot(user.var1, user.var2, "User", TRUE)

