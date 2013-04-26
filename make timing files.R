#### now create timing files

library('R.matlab')

projdir<-"/Users/Jim/PARC_study/Jim_scripts"
setwd(projdir)

source("matreaderPARC.R")
source("binarytimingvector.R")
source("nearestTR.R")

behavepilotloc<-"/Users/Jim/Dropbox/PARC pilot data/beahvioral data/"
setwd(behavepilotloc)
files<-dir()
files[grep("localizer",files)]


#### let's go with T's files (to start)
# PARC_sub99902_localizer_block2_study
# PARC_sub99903_localizer_block1_study

### possible input vars
TRstodrop<-3
TRlength<-2
TRsinScan<- 220
stimlength<-6 #seconds

pilotdat<-matreaderPARC("PARC_sub99902_localizer_block2_study.mat")
# pilotdat<-matreaderPARC("PARC_sub99903_localizer_block1_study.mat")

str(pilotdat)

## get subset of trials interested in
pilotdat<-pilotdat[pilotdat$onsetRaw!=0,]

##### use scanner start time to calculate onsets/offsets!
pilotdat$onset_fromscannerstart<-pilotdat$onsetRaw-pilotdat$scanstartTime
pilotdat$offset_fromscannerstart<-pilotdat$offsetRaw-pilotdat$scanstartTime

pilotdat$onset_trim<-pilotdat$onset_fromscannerstart-(TRstodrop*TRlength) 
pilotdat$offset_trim<-pilotdat$offset_fromscannerstart-(TRstodrop*TRlength)

max(pilotdat$offset_trim)
## get onset/offsets expressed in TRs
pilotdat$TR_onset<-nearestTR(pilotdat$onset_trim,TRlength)
pilotdat$TR_offset<-nearestTR(pilotdat$offset_trim,TRlength)
max(pilotdat$TR_offset)



#### make vectors for FSL 
person_onset<-binarytimingvector(pilotdat[pilotdat$imgType=='person','TR_onset'],220)
place_onset<-binarytimingvector(pilotdat[pilotdat$imgType=='place','TR_onset'],220)

person_long<-binarytimingvector(pilotdat[pilotdat$imgType=='person','TR_onset'],220,eventlength=3)
place_long<-binarytimingvector(pilotdat[pilotdat$imgType=='place','TR_onset'],220,eventlength=3)



setwd("~/PARC_study/trial_es_loc_pilot/pilot3/behavioral_files/")
write(person_onset,"person_onset.txt")
write(place_onset,"place_onset.txt")

write(person_long,"person_long.txt")
write(place_long,"place_long.txt")

##### suck my balls, afni
setwd("~/PARC_study/trial_es_loc_pilot/pilot3/behavioral_files/forafni/")

s1_person_afni<-round(pilotdat[pilotdat$imgType=='person','onset_trim'],2)
s1_place_afni<-round(pilotdat[pilotdat$imgType=='place','onset_trim'],2)
# 
# write(s1_person_afni,file="s1_person_afni.1D",ncolumns=1)
# save(s1_person_afni,file="s1_person_afni.1D",ascii=TRUE)
# write(s1_place_afni,"s1_place_afni.1D")

sink(file="s1_person_afni.1D")
cat(s1_person_afni,sep=" ")
sink(file=NULL)

sink(file="s1_place_afni.1D")
cat(s1_place_afni,sep=" ")
sink(file=NULL)



#### other junk ######### 



# 
# 
# ## make binary onset vector
# binaryoffset<-rep(0,TRsinScan)
# binaryoffset[pilotdat$TR_offset]<-1
# binaryoffset
# 
# 
# # binary vector when on
# TRsinScan<- 220
# stimlength<-6 #seconds
# stimTR<-stimlength/TRlength #how long stim in TRs
# reppedonsets<-rep(pilotdat$TR_offset,each=stimTR)
# reppedonsets<-reppedonsets+(0:(stimTR-1))
# binaryoffset

source('~/PARC_study/Jim_scripts/binarytimingvector.R', echo=TRUE)
binarytimingvector(pilotdat$TR_offset,220,eventlength=3)


# for faces and onsets
str(pilotdat)


### first pilot data 
# pilot1dat<-matreaderPARC("PARC_sub99902_localizer_block1_study_mel.mat")

# how many volumes in registereed functional?
# filtered data has 224

### weird shit with monday's pilots: 
# T's data seems to not be stored in parc.  Mel's data is spread over pilot 2 and pilot 3 folders??


