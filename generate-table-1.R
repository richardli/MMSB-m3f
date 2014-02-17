burnin = 400
n.gibbs = 500
ku.set <- c(5, 10, 20, 30)
km.set <- c(5, 10, 10, 30)
rmse <- matrix(0, 4, 4)
for(r in seq(1:4)){
	for(c in seq(1:4)){
		KU = ku.set[r]
		KM = km.set[r]
		numFacs = c * 10
		direc <- "~/Dropbox/Big-data-workspace/m3f/testing/m3f_tib-meta/log/"	
		path1 <- paste(direc, "m3f_tib_movielens100k_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, "_init", 1, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		out1 <- loadm3ftiblog(path1, burnin = burnin, length = n.gibbs, KM , KU )
		out2 <- loadm3ftiblog(path2, burnin = burnin, length = n.gibbs, KM , KU )
		rmse[r, c] <- mean(c(out1$rmse.test[100], out2$rmse.test[100]))
	}
}
round(rmse,4)

rmse <- matrix(0, 4, 4)
for(r in seq(1:4)){
	for(c in seq(1:4)){
		KU = ku.set[r]
		KM = km.set[r]
		numFacs = c * 10
		direc <- "~/Dropbox/Big-data-workspace/m3f/testing/m3f_tif-meta/log"	
		path1 <- paste(direc, "m3f_tif_movielens100k_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, "_init", 1, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		out1 <- loadm3ftiblog(path1, burnin = burnin, length = n.gibbs, KM , KU )
		out2 <- loadm3ftiblog(path2, burnin = burnin, length = n.gibbs, KM , KU )
		rmse[r, c] <- mean(c(out1$rmse.test[100], out2$rmse.test[100]))
	}
}
round(rmse,4)