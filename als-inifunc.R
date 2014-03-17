# process R data L/R matrix into mm file
library(Matrix)
load("~/Dropbox/Big-data-project/EM_if_it_works/100MboostedALS.model")
R <- fit[[2]]
Rsp <- Matrix(R, sparse = TRUE)
writeMM(Rsp, "~/Dropbox/100ALS-V.mm")
L <- fit[[1]]
Lsp <- Matrix(L, sparse = TRUE)
writeMM(Lsp, "~/Dropbox/100ALS-U.mm")

x <- c(876,	1504	,785,	517,	270)
write(x/sum(x), file = "~/Dropbox/Big-data-workspace/m3f/testing/kmeansKMdist-dim5als.txt", sep = ",")

x <- c(852,	342,	187,272,	494,	607,	270,422,369,137)
write(x/sum(x), file = "~/Dropbox/Big-data-workspace/m3f/testing/kmeansKMdist-dim10als.txt", sep = ",")

x <- c(56,	270,	147,	319,	295	,323	,455,	59	,297,	318	,246	,116,	262	,712	,77)
write(x/sum(x), file = "~/Dropbox/Big-data-workspace/m3f/testing/kmeansKMdist-dim15als.txt", sep = ",")

x <- c(226	,678	,209	,198	,172	,63	,122	,281,	83,	256	,159	,270	,160	,36	,355	,378)
write(x/sum(x), file = "~/Dropbox/Big-data-workspace/m3f/testing/kmeansKMdist-dim20als.txt", sep = ",")

x <- c(194,	150,	67,	123,	522,	37,	18	,147,	248,	103,	121,	307,	80,	270,	81,	99	,49,	218,	213,	40	,246	,221	,36	,89	,273)
write(x/sum(x), file = "~/Dropbox/Big-data-workspace/m3f/testing/kmeansKMdist-dim25als.txt", sep = ",")


