#####################################################
path <- getpath(model, data, numFacs, KU, KM, 
				distSeed, init, numTopicFacs)
if(model == "tib"){
	out1 <- loadm3ftiblog(path$path1, burnin = burnin, 
					  length = n.gibbs, KM , KU )
	out2 <- loadm3ftiblog(path$path2, burnin = burnin, 
					  length = n.gibbs, KM , KU )	
}else{
	out1 <- loadm3flog(path$path1, burnin = burnin, 
					   length = n.gibbs, KM , KU )
	out2 <- loadm3flog(path$path2, burnin = burnin, 
					   length = n.gibbs, KM , KU )
}
rmse <- mean(c(out1$rmse.test[n.gibbs - burnin],
			   out2$rmse.test[n.gibbs - burnin]))
###################################################
item1 <- read.table(path$item1, header = TRUE)
item2 <- read.table(path$item2, header = TRUE)
user1 <- read.table(path$user1, header = TRUE)
user2 <- read.table(path$user2, header = TRUE)
###################################################
item.toplot <- findTopVar(item1, item2, min.count = 20, max.out = 100)
user.toplot <- findTopVar(user1, user2, min.count = 20, max.out = 100)