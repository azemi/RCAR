Vote<-read.table("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/house-Votes-84.data",sep=",",na.strings="?",h=F)
colnames(Vote)<-c("Class.Name","handicapped.infants","water.project.cost.sharing","adoption.of.the.budget.resolution","physician.fee.freeze","el.salvador.aid","religious.groups.in.schools","anti.satellite.test.ban","aid.to.nicaraguan.contras","mx.missile","immigration","synfuels.corporation.cutback","education.spending","superfund.right.to.sue","crime","duty.free.exports","export.administration.act.south.africa")
#Vote<-as.data.frame(na.omit(Vote))



Mush<-read.table("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/agaricus-lepiota.data", sep=",",h=FALSE,na.strings=" ?")
colnames(Mush)<-c("classe","CapShape","capSurface","capColor","bruises","odor","gillAttachment","gillSpacing","gillSize","gillColor","stalkShape","stalkRoot","stalkSurfaceAboveRing","stalkSurfaceBelowRing","stalkColorAboveRing","stalkColorBelowRing","veilType","veilColor","ringNumber","ringType","sporePrintColor","population","habitat")
#Mush<-na.omit(Mush[,-17])  #One value variable

Cancer<-read.table("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/breast-cancer.data", sep=",",h=FALSE,na.strings=" ?")
colnames(Cancer)<-c("Class","age","menopause","tumorSize","invNodes","nodeCaps","degMalig","breast","breastQuad","irradiat")
#Cancer<-na.omit(Cancer)
#Cancer[,7]<-as.factor(Cancer[,7])

Car<-read.table("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/car.data", sep=",",h=FALSE,na.strings=" ?")
colnames(Car)<-c("buying","maint","doors","persons","lugBoot","safety","Class")
#Car<-na.omit(Car)


Balance <- read.csv("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/balance-scale.data", header=FALSE)
colnames(Balance)<-c("Class","Left_Weight","Left_Distance","Right_Weight","Right_Distance")
#Balance<-na.omit(Balance)


Tictac<-read.table("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/tic-tac-toe.data", sep=",",h=FALSE)
colnames(Tictac)<-c("top_left_square","top_middle_square","top_right_square","middle_left_square","middle_middle_square","middle_right_square","bottom_left_square","bottom_middle_square","bottom_right_square","Class")
#Tictac<-na.omit(Tictac)

Spect <- read.csv("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/SPECT.data", header=FALSE)
colnames(Spect)<-c("Class","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","F13","F14","F15","F16","F17","F18","F19","F20","F21","F22")
#Spect<-na.omit(Spect)
#for(j in 1:ncol(Spect)){
#  Spect[,j]<-as.factor(Spect[,j])
#}


Nursery <- read.csv("C:/Users/Mohamed/Google Drive/Mes articles/data for experiment analysis/nursery.data", header=FALSE)
colnames(Nursery)<-c("parents","has_nurs","form","children","housing","finance","social","health","Class")
#Nursery<-na.omit(Nursery[-c(1,4),])

devtools::use_data(Vote, Vote, overwrite = TRUE)
devtools::use_data(Mush, Mush, overwrite = TRUE)
devtools::use_data(Cancer, Cancer, overwrite = TRUE)
devtools::use_data(Car, Car, overwrite = TRUE)
devtools::use_data(Balance,Balance, overwrite = TRUE)
devtools::use_data(Tictac,Tictac, overwrite = TRUE)
devtools::use_data(Spect,Spect, overwrite = TRUE)
devtools::use_data(Nursery,Nursery, overwrite = TRUE)
