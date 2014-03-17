test <- read.delim("~/Dropbox/Big-data-project/LLORMA/r100.test",header=FALSE,sep=":")[,c(1,3,5)]
ranks = c(10, 20)
for(i in 1:2){
	load(paste("~/Dropbox/Big-data-project/EM_if_it_works/100MSGD", ranks[i], ".model", sep = ""))
	Mpred <- fit$L %*% t(fit$R)
	pred <- rep(0, dim(test)[1])
	pred <- sapply(seq(1, dim(test)[1]), 
			  function(i){
			  	Mpred[test[i,1], test[i,2]]
			  })
	write(pred, 
    	  file = paste("~/Dropbox/Big-data-workspace/m3f/testing/sgd/100rank", ranks[i],  sep = ""), 
      	sep = "\n")
}

test <- read.delim("~/Dropbox/Big-data-project/LLORMA/r101.test",header=FALSE,sep=":")[,c(1,3,5)]
ranks = c(10, 20)
for(i in 1:2){
	load(paste("~/Dropbox/Big-data-project/EM_if_it_works/101MSGD", ranks[i], ".model", sep = ""))
	Mpred <- fit$L %*% t(fit$R)
	pred <- rep(0, dim(test)[1])
	pred <- sapply(seq(1, dim(test)[1]), 
			  function(i){
			  	Mpred[test[i,1], test[i,2]]
			  })
	write(pred, 
    	  file = paste("~/Dropbox/Big-data-workspace/m3f/testing/sgd/101rank", ranks[i],  sep = ""), 
      	sep = "\n")
}