nearestTR<-function(timevector,TRlength){
  # converst seconds to TRs, round via midpoints
  midpoint<-TRlength/2
  remainders<-timevector %% TRlength
  baseTR<-timevector %/% TRlength
  TRvec<-baseTR+as.numeric(remainders>=midpoint)
  return(TRvec)
}
