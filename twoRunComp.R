	source("~/Dropbox/Big-data-workspace/helperFunc.R")
	####################################################
	##
	## First set of parameter
	##
	data = 'movielens1M'
	numFacs = 20
	KU = 2
	KM = 25
	init = 3
	numTopicFacs = 2
	n.gibbs = 500
	burnin = 300
	distSeed = 11
	model = 'tib'
	#####################
	min.count <- 300
	max.out <- 10
	#####################
	# open one run's RMSE
	source("~/Dropbox/Big-data-workspace/OneRunAna.R")
	rmse1 <- rmse
	item.var1 <- item.toplot
	user.var1 <- user.toplot
	######################
	toplowplot(item.var1[[1]], item.var1[[2]], rmse1, head = "Uneven prior: Movie - ")
	toplowplot(user.var1[[1]], user.var1[[2]], rmse1, head = "Uneven prior: User - ")
	
	#####################
	###
	###  change the corresponding parameter here
	###
	#KU = 2
	#KM = 5
	distSeed = 0
	#####################
	source("~/Dropbox/Big-data-workspace/OneRunAna.R")
	rmse2 <- rmse
	item.var2 <- item.toplot
	user.var2 <- user.toplot
	#####################
	toplowplot(item.var2[[1]], item.var2[[2]], rmse2, head = "Even prior: Movie - ")
	toplowplot(user.var2[[1]], user.var2[[2]], rmse2, head = "Even prior: User - ")
	#
	# plot improvement of 1 against 2 against variance
	#
	#####################
	# all correlation
	tworunplot(item.var1, item.var2, "Movie", FALSE, noplot = is.null(max.out))
	tworunplot(user.var1, user.var2, "User", FALSE, noplot = is.null(max.out))
	