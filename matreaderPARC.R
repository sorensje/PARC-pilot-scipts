##### Jim's PARC reader #### 
# file to read .mat file from RPARC into R
# works on flat structure
# reqwuires package R.matlab to read file

matreaderPARC<-function(datnam){
  
  dat<-readMat(datnam)
  variables<-names(dat)
  nvars<-length(variables)
  
  ## check if dimensions are either 96 or 1...
  matdims<-NULL
  for (ii in 1:nvars){
    blah<-unlist(dat[ii])
    num_elements<-length(names(blah))
    matdims<-c(matdims,num_elements)
  }
  ntrials<-max(matdims)

  if (length(unique(matdims))==2){   # double check structure read such that variables have single or ntrial elements
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
  } else (print ('more than 2 lengths of variables'))
  
  ### this method makes everything a factor, this code makes everything that can be numeric numberic
  for (ii in 1:nvars){
    blah<-NULL
    blah<-as.character(newdat[1,ii])
    blah<-suppressWarnings(as(blah,"numeric"))
    if(is.finite(blah)){
        newdat[,ii]<-as.numeric(as.character(newdat[,ii]))
    }
  }  
  
  return(newdat)
}

