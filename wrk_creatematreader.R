### can I read in my matlab files?

library('R.matlab')
setwd("/Users/Jim/Dropbox/PARC pilot data/beahvioral data/")
dat<-readMat("PARC_sub99902_localizer_block1_study_mel.mat")


str(dat)
dim(dat$sub)
dim(dat)

variables<-names(dat)
nvars<-length(variables)

dim(dat[variables[1]])
struc<-str(dat)
dim(dat['index'])
dim(dat[1])



## check if dimensions are either 96 or 1...
matdims<-NULL
for (ii in 1:nvars){
  blah<-unlist(dat[ii])
  num_elements<-length(names(blah))
  matdims<-c(matdims,num_elements)
}

length(unique(matdims))==2
ntrials<-max(matdims)



newdat<-NULL
for (ii in 1:nvars){
#   print(dim(dat[variables[ii]]))
  blah<-unlist(dat[ii])
  num_elements<-length(names(blah))
  
 if (num_elements==1){
   longvar<-rep(blah[[1]],ntrials)
 } else{
   longvar<-unlist(dat[ii],use.names=FALSE)
   }
  newdat<-cbind(newdat,longvar)
}
newdat<-as.data.frame(newdat)  
names(newdat)<-variables