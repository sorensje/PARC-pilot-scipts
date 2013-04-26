binarytimingvector<-function(onsetvect,n_volumes,dataformat="TRs",TRlength=2,eventlength=1){
  #take vector of onsets experessed in seconds or TRs
  # and make binary timing vector (for fsl etc...)
  # 
  # event length should be in TRs, default is to treat event as 
  # 1 TR long (which is the same as an onset vector)
  # 
  
  binarytimingvector<-rep(0,n_volumes)
  
  switch(dataformat,
         "TRs"={onsetvect_TRed<-onsetvect
         },
         "Secs"={
           onsetvect_TRed<-nearestTR(onsetvect,TRlength)
         },
         stop("choose valid format of input vctor")
         )
  
  reppedonsets<-rep(onsetvect_TRed,each=eventlength)
  reppedonsets<-reppedonsets+(1:(eventlength)) # was 0:(blah-1) but this way corrects for TR counting starting at 0
  binarytimingvector[reppedonsets]<-1
  
  return(binarytimingvector)
  
}
  