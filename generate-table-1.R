burnin = 400
n.gibbs = 500
ku.set <- c(2, 5, 10, 20)
km.set <- c(1, 5, 10, 10)
rmse.tib <- matrix(0, 4, 4)
for(r in seq(1:4)){
	for(c in seq(1:4)){
		KU = ku.set[r]
		KM = km.set[r]
		numFacs = c * 10
		direc <- "~/Dropbox/Big-data-workspace/m3f/testing/m3f_tib-meta500/log/"	
		path1 <- paste(direc, "m3f_tib_movielens100k_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, "_init", 3, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		out1 <- loadm3ftiblog(path1, burnin = burnin, length = n.gibbs, KM , KU )
		out2 <- loadm3ftiblog(path2, burnin = burnin, length = n.gibbs, KM , KU )
		rmse.tib[r, c] <- mean(c(out1$rmse.test[n.gibbs - burnin],
								 out2$rmse.test[n.gibbs - burnin]))
	}
}
round(rmse.tib,4)

rmse.tif <- matrix(0, 4, 4)
for(r in seq(1:4)){
	for(c in seq(1:4)){
		KU = ku.set[r]
		KM = km.set[r]
		numFacs = c * 10
		direc <- "~/Dropbox/Big-data-workspace/m3f/testing/m3f_tif-meta500/log/"	
		path1 <- paste(direc, "m3f_tif_movielens100k_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, "_numTopicFacs2_init", 3, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		out1 <- loadm3flog(path1, burnin = burnin, length = n.gibbs, KM , KU )
		out2 <- loadm3flog(path2, burnin = burnin, length = n.gibbs, KM , KU )
		rmse.tif[r, c] <- mean(c(out1$rmse.test[n.gibbs - burnin], 
							     out2$rmse.test[n.gibbs - burnin]))
	}
}
round(rmse.tif,4)