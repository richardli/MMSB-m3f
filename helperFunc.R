# function to read data

path <- function(model, data, numFacs, KU, KM, distSeed, init, 
				numTopicFacs = NULL){
	if(model == 'tib'){
		header = paste("Prior", distSeed, "-m3f_tib-KU", KU, "-KM", KM,
						"-NumFacs", numFacs, sep = "")
	}
	
	if(model == 'tif'){
		header = paste("Prior", distSeed, "-m3f_tif-KU", KU, "-KM", KM,
						"-NumFacs", numFacs, sep = "")
	}
	#####################################################################
	direc <- paste("~/Dropbox/Big-data-workspace/m3f/testing/results/", 
					header, "/log/", sep="")
	if(model == 'tib'){
		path1 <- paste(direc, "m3f_", model, "_", data, 
						"_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, 
						"_init", init, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		path.item1 <- paste(direc, "m3f_", model, 
						"ItermMatrix_", data, "_split100_model-numFacs", 
						 numFacs, "_KU", KU,"_KM", KM, 											 "_init", init, ".log", sep="")
		path.item2 <- gsub("split100", "split101", path.item1)
		path.user1 <- paste(direc, "m3f_", model, 
						"UserMatrix_", data, "_split100_model-numFacs", 
						 numFacs, "_KU", KU,"_KM", KM, 											 "_init", init, ".log", sep="")
		path.user2 <- gsub("split100", "split101", path.user1)
	}				
	if(model == 'tif'){
		path1 <- paste(direc, "m3f_", model, "_", data, 
						"_split100_model-numFacs", 
						numFacs, "_KU", KU,"_KM", KM, 
						"_numTopicFacs2", numTopicFacs, 
						"_init", init, ".log", sep="")
		path2 <- gsub("split100", "split101", path1)
		path.item1 <- paste(direc, "m3f_", model, 
						"ItermMatrix_", data, "_split100_model-numFacs", 
						 numFacs, "_KU", KU,"_KM", KM, 
						 "_numTopicFacs", numTopicFacs,										 			 "_init", init, ".log", sep="")
		path.item2 <- gsub("split100", "split101", path.item1)
		path.user1 <- paste(direc, "m3f_", model, 
						"UserMatrix_", data, "_split100_model-numFacs", 
						 numFacs, "_KU", KU,"_KM", KM, 
						 "_numTopicFacs", numTopicFacs,										 			 "_init", init, ".log", sep="")
		path.user2 <- gsub("split100", "split101", path.user1)
	}
	
	return(list(item1 = path.item1, 
				item2 = path.item2, 
				user1 = path.user1, 
				user2 = path.user2, 
				path1 = path1, 
				path2 = path2))				
					
}


findTopVar <- function(item.1, item.2, min.count, max.out, top){
	allvar <- (item.1[, 3] + item.2[, 3]) / 2
	all.train <- (item.1[, 2] + item.2[, 2]) / 2
	all.test <- (item.1[, 1] + item.2[, 1]) / 2
	
	if(min.count < 1) min.count <- max(quantile(item.1[,4], min.count), 	
										quantile(item.2[,4], min.count))
	tolook <- intersect(which(item.1[,4] > min.count), 
							  which(item.2[,4] > min.count))
	tolook <- setdiff(tolook, union(which(is.na(all.train)), 
									which(is.na(all.test))))
	allvar.tolook <- allvar[tolook]
	all.train.tolook <- all.train[tolook]
	all.test.tolook <- all.test[tolook]
	# determine if the top or bottom should be returned
	output.index <- order(allvar.tolook, decreasing = top)[1:max.out]
	output.train = all.train.tolook[output.index]
	output.test = all.test.tolook[output.index]						 
	return(list(train = output.train, 
				test = output.test, 
				var = allvar.tolook[output.index])) 
}

toplowplot <- function(tib.toplot, tib.toplot.low){
	yscale <- range(c(tib.toplot[[1]], tib.toplot[[2]], 
					tib.toplot.low[[1]], tib.toplot.low[[2]]))
	par(mfrow = c(1, 2))
	plot(tib.toplot.low$var, tib.toplot.low$test, 
		 xlab = "Variance in training set", 
		 ylab = "RMSE in testing set", 
		 main = " least variable", 
		 ylim = yscale)
	points(tib.toplot.low$var, tib.toplot.low$train, col = "red")
	
	plot(tib.toplot$var, tib.toplot$test, 
		 xlab = "Variance in training set", 
		 ylab = "RMSE in testing set", 
		 main = " most variable", 
		 ylim = yscale)
	points(tib.toplot$var, tib.toplot$train, col = "red")
}
