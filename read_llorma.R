test <- read.delim("~/Dropbox/Big-data-project/LLORMA/r100.test",header=FALSE,sep=":")[,c(1,3,5)]
load("~/Dropbox/Big-data-project/LLORMA/100MLLORMA-B.model")
source("~/Dropbox/Big-data-project/LLORMA/LLORMA_functions.R")
ranks <- c(20) 
nmodels <- c(length(fit))

for(i in 1:length(ranks)) {
  tfit <- lapply(fit,function(x) list(list(x[[1]][[1]][,1:ranks[i]],x[[1]][[2]][,1:ranks[i]]),x[[2]],x[[3]]))
  for(j in 1:length(nmodels)) {
    pred <- apply(test,1,predict.LLORMA,tfit[1:j])
    pred[which(is.na(pred))] <- 3
    write(pred, 
    file = paste("~/Dropbox/Big-data-workspace/m3f/testing/llorma/100rank", 
    			ranks[i], "Nmodels", nmodels[j], sep = ""), 
    sep = "\n")
  }
}

#####################
test <- read.delim("~/Dropbox/Big-data-project/LLORMA/r101.test",header=FALSE,sep=":")[,c(1,3,5)]
load("~/Dropbox/Big-data-project/LLORMA/101MLLORMA-B.model")
source("~/Dropbox/Big-data-project/LLORMA/LLORMA_functions.R")
#ranks <- c(10,20,30,40)
#nmodels <- c(2:length(fit))

for(i in 1:length(ranks)) {
  tfit <- lapply(fit,function(x) list(list(x[[1]][[1]][,1:ranks[i]],x[[1]][[2]][,1:ranks[i]]),x[[2]],x[[3]]))
  for(j in 1:length(nmodels)) {
    pred <- apply(test,1,predict.LLORMA,tfit[1:j])
    pred[which(is.na(pred))] <- 3
    write(pred, 
    file = paste("~/Dropbox/Big-data-workspace/m3f/testing/llorma/101rank", 
    			ranks[i], "Nmodels", nmodels[i], sep = ""), 
    sep = "\n")
  }
}
