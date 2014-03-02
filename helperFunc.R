# function to get all path needed
#
#
getpath <- function(model, data, numFacs, KU, KM, distSeed, init, 
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
						"_numTopicFacs", numTopicFacs, 
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

# function to find top/bottom variances and related RMSE
#
#
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
	# for the top
	output.index <- order(allvar.tolook, decreasing = TRUE)[1:max.out]
	output.train = all.train.tolook[output.index]
	output.test = all.test.tolook[output.index]						 
	top <- list(train = output.train, 
				test = output.test, 
				var = allvar.tolook[output.index])
	# for the bottome 
	output.index2 <- order(allvar.tolook, decreasing = FALSE)[1:max.out]
	output.train2 = all.train.tolook[output.index2]
	output.test2 = all.test.tolook[output.index2]					
	bottom <- list(train = output.train2, 
				test = output.test2, 
				var = allvar.tolook[output.index2])			
	return(list(top = top, bottom = bottom))
}

# function to plot top and bottome variances versus RMSE
#
#
toplowplot <- function(tib.toplot, tib.toplot.low, head){
	yscale <- range(c(tib.toplot[[1]], tib.toplot[[2]], 
					tib.toplot.low[[1]], tib.toplot.low[[2]]))
	par(mfrow = c(1, 2))
	plot(tib.toplot.low$var, tib.toplot.low$test, 
		 xlab = "Variance in training set", 
		 ylab = "RMSE in testing set", 
		 main = paste(head,  "least variable"), 
		 ylim = yscale)
	points(tib.toplot.low$var, tib.toplot.low$train, col = "red")
	
	plot(tib.toplot$var, tib.toplot$test, 
		 xlab = "Variance in training set", 
		 ylab = "RMSE in testing set", 
		 main = paste(head, "most variable"), 
		 ylim = yscale)
	points(tib.toplot$var, tib.toplot$train, col = "red")
}

# functions to compare two runs
#
#
tworunplot <- function(item.var1, item.var2, header, plottrain = FALSE){
	if((sum(item.var2[[1]]$var - item.var1[[1]]$var) != 0)
		||(sum(item.var2[[2]]$var - item.var1[[2]]$var) != 0)){
			print("Wrong comparison")
			return
		}		
	testup <- item.var1[[1]]$test - item.var2[[1]]$test 
	testlow <- item.var1[[2]]$test - item.var2[[2]]$test 
	trainup <- item.var1[[1]]$train - item.var2[[1]]$train 
	trainlow <- item.var1[[2]]$train - item.var2[[2]]$train
	# note the two variance should be the same
	yscale <- range(c( testup, testlow, trainup, trainlow))
	par(mfrow = c(1,2))
	plot(item.var1[[2]]$var, testlow,  
		 xlab = "Variance in training set", 
		 ylab = "difference in RMSE", 
		 main = paste(header,  "least variable"), 
		 ylim = yscale)
	abline(h = 0, col = "blue")
	if(plottrain){
		points(item.var1[[2]]$var, trainlow, col = "red")
	}	 
	plot(item.var1[[1]]$var, testup,  
		 xlab = "Variance in training set", 
		 ylab = "difference in RMSE", 
		 main = paste(header,  "most variable"), 
		 ylim = yscale)
	abline(h = 0, col = "blue")
	if(plottrain){
		points(item.var1[[1]]$var, trainup, col = "red")
	}	 					
}

# functions to load regular log data
#
#
## helper function: read log file and parse input
loadm3flog <- function(path, burnin, length, KM, KU){	
	# declare variables
	rmse.train <- rep(0, length - burnin)
	rmse.test <- rep(0, length - burnin)
	mae.train <- rep(0, length - burnin)
	mae.test <- rep(0, length - burnin)
	time <- rep(0, length - burnin)
	a.norm <- b.norm <- rep(0, length - burnin)
	lambda.U.norm <- lambda.M.norm <- rep(0, length - burnin)
	lambda.tildeU.norm <- lambda.tildeM.norm <- rep(0, length - burnin)
	c.norm <- zM.count <- matrix(0, nrow = length - burnin, ncol = KM)
	d.norm <- zU.count <-matrix(0, nrow = length - burnin, ncol = KU)
	
	# read log file
	path <- file(path)
	open(path)
	# throw away the first three lines
	print("throw away:")
	print(readLines(path, n = 3, warn = FALSE))
	while(length(pack <- readLines(path, n = 12, warn = FALSE)) > 0){
		itr <- as.numeric(strsplit(pack[1], " ")[[1]][2])
		if(itr %% 50 == 0) cat( ".")
		pack <- gsub(",","",pack)
		if(itr <= burnin) next;
		rmse.train[itr-burnin] <- as.numeric(strsplit(pack[2], " ")[[1]][4])
		rmse.test[itr-burnin] <- as.numeric(strsplit(pack[3], " ")[[1]][4])
		mae.train[itr-burnin] <- as.numeric(strsplit(pack[2], " ")[[1]][8])
		mae.test[itr-burnin] <- as.numeric(strsplit(pack[3], " ")[[1]][4])
		time[itr-burnin] <- as.numeric(strsplit(pack[4], " ")[[1]][3])
		
		lambda.U.norm[itr-burnin] <- as.numeric(strsplit(pack[6], " ")[[1]][4])
		lambda.M.norm[itr-burnin] <- as.numeric(strsplit(pack[6], " ")[[1]][8])
		lambda.tildeU.norm[itr-burnin] <- as.numeric(strsplit(pack[7], " ")[[1]][4])
		lambda.tildeM.norm[itr-burnin] <- as.numeric(strsplit(pack[7], " ")[[1]][8])
		
		a.norm[itr-burnin] <- as.numeric(strsplit(pack[8], " ")[[1]][4])
		b.norm[itr-burnin] <- as.numeric(strsplit(pack[8], " ")[[1]][8])
		c.norm[itr-burnin, ] <- as.numeric(strsplit(pack[9], " ")[[1]][4 :(3 + KM)])
		d.norm[itr-burnin, ] <- as.numeric(strsplit(pack[10], " ")[[1]][4 :(3 + KU)])
		zM.count[itr-burnin, ] <- as.numeric(strsplit(pack[11], " ")[[1]][4 :(3 + KM)])
		zU.count[itr-burnin, ] <- as.numeric(strsplit(pack[12], " ")[[1]][4 :(3 + KU)])	
	} 
	close(path)	
	return(list(rmse.train = rmse.train, 
				rmse.test = rmse.test, 
				mae.train = mae.train, 
				mae.test = mae.test, 
				time = time, 
				lambda.U.norm = lambda.U.norm, 
				lambda.M.norm = lambda.M.norm, 
				lambda.tildeU.norm = lambda.tildeU.norm, 
				lambda.tildeM.norm = lambda.tildeM.norm, 
				a.norm = a.norm, 
				b.norm = b.norm, 
				c.norm = c.norm, 
				d.norm = d.norm, 
				zM.count = zM.count, 
				zU.count = zU.count))
}
loadm3ftiblog <- function(path, burnin, length, KM, KU){	
	# declare variables
	rmse.train <- rep(0, length - burnin)
	rmse.test <- rep(0, length - burnin)
	mae.train <- rep(0, length - burnin)
	mae.test <- rep(0, length - burnin)
	time <- rep(0, length - burnin)
	a.norm <- b.norm <- c.norm <- d.norm <- rep(0, length - burnin)
	lambda.U.norm <- lambda.M.norm <- rep(0, length - burnin)
	zM.count <- matrix(0, nrow = length - burnin, ncol = KM)
	zU.count <-matrix(0, nrow = length - burnin, ncol = KU)
	
	# read log file
	path <- file(path)
	open(path)
	# throw away the first three lines
	print("throw away:")
	print(readLines(path, n = 3, warn = FALSE))
	while(length(pack <- readLines(path, n = 10, warn = FALSE)) > 0){
		itr <- as.numeric(strsplit(pack[1], " ")[[1]][2])
		if(itr %% 50 == 0) cat(".")
		pack <- gsub(",","",pack)
		if(itr <= burnin) next;
		rmse.train[itr-burnin] <- as.numeric(strsplit(pack[2], " ")[[1]][4])
		rmse.test[itr-burnin] <- as.numeric(strsplit(pack[3], " ")[[1]][4])
		mae.train[itr-burnin] <- as.numeric(strsplit(pack[2], " ")[[1]][8])
		mae.test[itr-burnin] <- as.numeric(strsplit(pack[3], " ")[[1]][4])
		time[itr-burnin] <- as.numeric(strsplit(pack[4], " ")[[1]][3])
		
		lambda.U.norm[itr-burnin] <- as.numeric(strsplit(pack[6], " ")[[1]][4])
		lambda.M.norm[itr-burnin] <- as.numeric(strsplit(pack[6], " ")[[1]][8])
		
		a.norm[itr-burnin] <- as.numeric(strsplit(pack[7], " ")[[1]][4])
		b.norm[itr-burnin] <- as.numeric(strsplit(pack[7], " ")[[1]][8])
		c.norm[itr-burnin] <- as.numeric(strsplit(pack[8], " ")[[1]][4])
		d.norm[itr-burnin] <- as.numeric(strsplit(pack[8], " ")[[1]][8])
		zM.count[itr-burnin, ] <- as.numeric(strsplit(pack[9], " ")[[1]][4 :(3 + KM)])
		zU.count[itr-burnin, ] <- as.numeric(strsplit(pack[10], " ")[[1]][4 :(3 + KU)])	
	} 
	close(path)	
	return(list(rmse.train = rmse.train, 
				rmse.test = rmse.test, 
				mae.train = mae.train, 
				mae.test = mae.test, 
				time = time, 
				lambda.U.norm = lambda.U.norm, 
				lambda.M.norm = lambda.M.norm, 
				a.norm = a.norm, 
				b.norm = b.norm, 
				c.norm = c.norm, 
				d.norm = d.norm, 
				zM.count = zM.count, 
				zU.count = zU.count))
}
