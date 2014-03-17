	source("~/Dropbox/Big-data-workspace/helperFunc.R")
	library(ggplot2)
	####################################################
	##
	## First set of parameter
	##
	data = 'movielens1M'
	movies <- ReadMovies("1M")		

	##
	distSeed = 301
	numFacs = 10
	KU = 10
	KM = 5
	init = 3
	numTopicFacs = 2
	n.gibbs = 500
	burnin = 400
	model = 'tif'
	numTopicFacs = 2
	#####################
	min.count <- 300
	max.out <- 10
	#########################################################
	# open one run's RMSE
	path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	item.1 <- results$item
	user.1 <- results$user	
	rmse.1 <- results$rmse
	movie <- results$movie	
    
	###########################################################
	 distSeed = 300
     path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	 results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	path.ll.rank10<- c("~/Dropbox/Big-data-workspace/m3f/testing/llorma/100rank10Nmodels50ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/llorma/101rank10Nmodels50ItermMatrix_movielens1M_split101_modelexternal_init")
	
	path.ll.rank20<- c("~/Dropbox/Big-data-workspace/m3f/testing/llorma/100rank20Nmodels50ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/llorma/101rank20Nmodels50ItermMatrix_movielens1M_split101_modelexternal_init")
	path.sgd.rank10<- c("~/Dropbox/Big-data-workspace/m3f/testing/sgd/100rank10ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/sgd/101rank10ItermMatrix_movielens1M_split101_modelexternal_init")
	
	path.sgd.rank20<- c("~/Dropbox/Big-data-workspace/m3f/testing/sgd/100rank20ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/sgd/101rank20ItermMatrix_movielens1M_split101_modelexternal_init")

	# results <- GetInfo(model, path.sgd.rank20, movies, singlefile = TRUE)
	item.2 <- results$item
	user.2 <- results$user
	rmse.2 <- results$rmse	
	Cond.compare(item.1, item.2, count = 10, var = NULL, number = 100)
	
	############################################################
	## compare
	## since the data are the same, the index is the same too
	item <- data.frame(variance = item.1[,3], 
			rmse = item.1[,1] - item.2[,1], 
			count = item.1[,4], 
			movie = movie)
	
	varplot(item, paste("KU =", KU, ", KM =",KM, ", D =", numFacs), 10,0)	
	varplot(item, "Improvements in RMSE comparing to original M3F", 10, 0)			
	############################################################		
varplot <- function(item, plottitle, min.count, min.var){
	item <- subset(item, variance > min.var & count>min.count)
	rmse.thre = quantile(abs(item$rmse), 0.99)	
	q.var <- order(item$variance)/length(item$variance)
	
	item <- cbind(item, q.var)
	gplot <- ggplot(item, aes(variance, rmse, label = movie)) + 
 			 geom_point(aes(size = count,  alpha = variance), 
 			 	col = rgb(0,0,1), pch = 16)+
 			 scale_size(range = c(2,10))+
 			 #geom_point(col=rgb(0,0,1,0.25), pch=16, cex=2) +
  			 geom_smooth(method="lm", formula=y~poly(x,2), fill = "grey80") +	
  			 geom_hline(yintercept = 0, colour = "red", alpha = 0.7, lty = 2) +	
  			 geom_text(data =subset(item, 
  			 					(variance > 2.01)|(abs(rmse)>rmse.thre & count>min.count)), 
	  			 aes(x=variance, y=rmse + rnorm(length(rmse),0,0.005), label=movie), 
	  			 color = "goldenrod", cex = 3)+
  			 labs(title= plottitle) +
  			 xlab("Variance")+
  			 ylab("Improvements in RMSE")+
 			 theme_bw() +
  			 theme(axis.text=element_text(size=14),
  			 axis.title=element_text(size=14),
  			 plot.title=element_text(size=16, face="bold"))
	gplot 
	}
		
	
	