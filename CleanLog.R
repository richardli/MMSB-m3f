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
#######################
KU = 20
KM = 20
numFacs = 10
numTopicFacs = 10
initial.mode = 2
burnin = 200
n.gibbs = 500
######################
direc <- paste("~/Dropbox/Big-data-workspace/m3f/testing/m3f_tif-KU", KU, "-KM", KM, "-NumFacs", numFacs, "-NumTopicFacs", numTopicFacs, "/log/", sep = "") 
path1 <- paste(direc, "m3f_tif_movielens100k_split1_model-numFacs", numFacs, "_KU", KU,"_KM", KM, "_numTopicFacs", numTopicFacs, "_init", initial.mode, ".log", sep="")
path2 <- gsub("split1",  "split2", path1)
path3 <- gsub("split1", "split3", path1)
path4 <- gsub("split1", "split4", path1)
path5 <- gsub("split1", "split5", path1)


out1 <- loadm3flog(path1, burnin = burnin, length = n.gibbs, KM , KU )
out2 <- loadm3flog(path2, burnin = burnin, length = n.gibbs, KM , KU )
out3 <- loadm3flog(path3, burnin = burnin, length = n.gibbs, KM , KU )
out4 <- loadm3flog(path4, burnin = burnin, length = n.gibbs, KM , KU )

out.ave <- lapply(seq(1:length(out1)), 
					function(i){(unlist(out1[[i]]) +
								  unlist(out2[[i]]) +
								  unlist(out3[[i]]) + 
								  unlist(out4[[i]]))/4}) 
#								  unlist(out5[[i]]) )/5})
names(out.ave) <- names(out1)
#########################
plot(out.ave$rmse.test, type = "l")
lines(out1$rmse.test, type = "l", col="red")
lines(out2$rmse.test, type = "l", col="red")
lines(out3$rmse.test, type = "l", col="red")
lines(out4$rmse.test, type = "l", col="red")

###########################################################################
path.a <- "~/Dropbox/Big-data-workspace/m3f/testing/m3f_tib-KU4-KM1-NumFacs10/log/m3f_tib_movielens10M_split100_model-numFacs10_KU4_KM1_init3.log" 
path.b <- gsub("split100", "split101", path.a)
out.a <- loadm3ftiblog(path.a, burnin = 400, length = 500, KM = 2, KU = 2)
out.b <- loadm3ftiblog(path.b, burnin = 400, length = 500, KM = 2, KU = 2)
##
##
rmse.a <- out.a$rmse.test
rmse.b <- out.b$rmse.test
plot(rmse.b, type = "l")
lines(rmse.a)
mean(c(rmse.b))
sd(c(rmse.a))
