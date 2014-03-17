source("~/Dropbox/Big-data-workspace/helperFunc.R")
movies <- ReadMovies("1M")		

table <- matrix(0, 5, 4)
rmsetable <- matrix(0, 5, 4)
ku = c(5,  10, 15, 20, 25)
km = c(5,  10,  15, 20, 25)
{
	path.sgd.rank10<- c("~/Dropbox/Big-data-workspace/m3f/testing/sgd/100rank10ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/sgd/101rank10ItermMatrix_movielens1M_split101_modelexternal_init")
	
	path.sgd.rank20<- c("~/Dropbox/Big-data-workspace/m3f/testing/sgd/100rank20ItermMatrix_movielens1M_split100_modelexternal_init", "~/Dropbox/Big-data-workspace/m3f/testing/sgd/101rank20ItermMatrix_movielens1M_split101_modelexternal_init")

sgd10 <- GetInfo(model, path.sgd.rank20, movies, singlefile = TRUE)
item.sgd10 <- sgd10$item
sgd20 <- GetInfo(model, path.sgd.rank20, movies, singlefile = TRUE)
item.sgd20 <- sgd20$item
}
for(i in 1:5){
	KU = ku[i]
	KM = km[i]
	init = 3
	numTopicFacs = 2
	n.gibbs = 500
	burnin = 300
	model = 'tib'
	data = "movielens1M"
	#########################################################
	numFacs = 10
	distSeed = 100
	#########################################################
	# open one run's RMSE
	path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	item.1 <- results$item
	rmse.1 <- results$rmse
	#########################################################
	# open one run's RMSE
	 distSeed = 101
     path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	 results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	 item.2 <- results$item
	 rmse.2 <- results$rmse
	 table[i, 1] <- Cond.compare(item.1, item.sgd10, count = 10, var = NULL, number = 100)$mean
	 table[i, 3] <- Cond.compare(item.2, item.sgd10, count = 10, var = NULL, number = 100)$mean
	 rmsetable[i,1] <- rmse.1
	 rmsetable[i,3] <- rmse.2
	 #########################################################
	numFacs = 20
	distSeed = 100
	#########################################################
	# open one run's RMSE
	path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	item.1 <- results$item		
	rmse.1 <- results$rmse
	#########################################################
	# open one run's RMSE
	 distSeed = 101
     path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)	
	 results <- GetInfo(model, path, movies, burnin, n.gibbs, KM, KU)
	 item.2 <- results$item	
	 rmse.2 <- results$rmse

	 table[i, 2] <- Cond.compare(item.1, item.sgd20, count = 10, var = NULL, number = 100)$mean
	 table[i, 4] <- Cond.compare(item.2, item.sgd20, count = 10, var = NULL, number = 100)$mean
	 rmsetable[i,2] <- rmse.1
	 rmsetable[i,4] <- rmse.2
	
}

print(round(table, 4))
print(round(rmsetable, 4))
rmsetable <- -rmsetable + cbind(rep(0.9197, 5), rep(0.9170, 5), 
								rep(0.9197, 5), rep(0.9170, 5))
########################################################
### restore to data that are erased :-(
table.restore <- matrix(c(0.0364, 0.0202 ,0.0414 ,0.0340 ,
           			0.0342 ,0.0206 ,0.0414 ,0.0378 ,
           			0.0200 ,0.0171, 0.0282 ,0.0352 ,
            		0.0305 ,0.0186, 0.0327 ,0.0239), 
            		nrow = 4, byrow = TRUE)
table.restore <- rbind(table[1, ], table.restore)

########################################################
rmse <- as.vector(table.restore)
name = c("(5,5)","(10,10)","(20,10)","(20,20)","(25,25)")
model <- rep(name, 4)
dimension <- c(rep(10,5), rep(20,5), rep(10,5), rep(20,5))
initial <- c(rep("original", 10), rep("bALS", 10))
data <- data.frame(rmse = rmse, model = model, dimension = dimension, initial = initial)


rmse <- as.vector(rmsetable)
name = c("(5,5)","(10,10)","(20,10)","(20,20)","(25,25)")
model <- rep(name, 4)
dimension <- c(rep(10,5), rep(20,5), rep(10,5), rep(20,5))
group <- c(rep("original(10)", 5),rep("original(20)", 5), rep("bALS(10)", 5), rep("bALS(20)", 5))
initial <- c(rep("original", 10), rep("bALS", 10))
rmsedata <- data.frame(rmse = rmse, model = model, dimension = dimension, group = group, initial = initial)

ggplot(data=rmsedata, aes(x=factor(model, levels = name), 
		y=rmse, 
		group=factor(group), 
		shape=as.factor(group), 
		color=group)) + geom_line() + geom_point()

qplot(x = factor(model, levels = name), y = rmse,
	  fill=factor(initial, levels = c("original", "bALS")),
	  geom="bar", stat="identity", position="dodge", 
	  alpha=I(2/3), width = 0.8,
	  data=subset(data, dimension == 10)) + 
theme(axis.text.x = element_text(angle=0, hjust=0.5, vjust=0)) +
ylim(c(0, 0.05)) +
xlab("Model (KU, KM)")+ylab("Improvement in RMSE")+
labs(title = "Dimension = 10")+
guides(fill=guide_legend(title="Initialization", reverse=FALSE))

qplot(x = factor(model, levels = name), y = rmse,
	  fill=factor(initial, levels = c("original", "bALS")),
	  geom="bar", stat="identity", position="dodge", 
	  alpha=I(2/3), width = 0.8,
	  data=subset(data, dimension == 20)) + 
theme(axis.text.x = element_text(angle=0, hjust=0.5, vjust=0)) +
ylim(c(0, 0.05)) +
xlab("Model (KU, KM)")+ylab("Improvement in RMSE")+
labs(title = "Dimension = 20")+
guides(fill=guide_legend(title="Initialization", reverse=FALSE))
