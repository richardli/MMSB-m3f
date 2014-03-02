data = 'movielens100k'
numFacs = 20
KU = 5
KM = 1
distSeed = 1;
init = 3
numTopicFacs = 2
N.gibbs = 100
burnin = 0
source("~/Dropbox/Big-data-workspace/helperFunc.R")
##########################################################
model = 'tif'
path.tif <- path(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)
model = 'tib'
path.tib <- path(model, data, numFacs, KU, KM, 
				distSeed, init)
##########################################################
item.1 <- read.table(path.tib$item1, header = TRUE)
item.2 <- read.table(path.tib$item2, header = TRUE)
item.1.tif <- read.table(path.tif$item1, header = TRUE)
item.2.tif <- read.table(path.tif$item2, header = TRUE)


tib.toplot <- findTopVar(item.1, item.2, min.count = 20, max.out = 100, top = TRUE)
tib.toplot.low <- findTopVar(item.1, item.2, min.count = 20, max.out = 100, top = FALSE)
tif.toplot <- findTopVar(item.1.tif, item.2.tif, min.count = 20, max.out = 100, top = TRUE)
tif.toplot.low <- findTopVar(item.1.tif, item.2.tif, min.count = 20, max.out = 100, top = FALSE)
####################################################
par(mfrow = c(1, 2))
plot(tib.toplot.low$var, tib.toplot.low$test, 
	 xlab = "Variance in training set", 
	 ylab = "RMSE in testing set", 
	 main = "M3F-TIB: least variable")
points(tib.toplot.low$var, tib.toplot.low$train, col = "red")

plot(tib.toplot$var, tib.toplot$test, 
	 xlab = "Variance in training set", 
	 ylab = "RMSE in testing set", 
	 main = "M3F-TIB: most variable")
points(tib.toplot$var, tib.toplot$train, col = "red")
#####################################################
plot(tif.toplot.low$var, tif.toplot.low$test, 
	 xlab = "Variance in training set", 
	 ylab = "RMSE in testing set", 
	 main = "M3F-TIF: least variable")
points(tif.toplot.low$var, tif.toplot.low$train, col = "red")

plot(tif.toplotvar, tif.toplot$test, 
	 xlab = "Variance in training set", 
	 ylab = "RMSE in testing set", 
	 main = "M3F-TIB: most variable")
points(tif.toplot$var, tif.toplot$train, col = "red")
#####################################################