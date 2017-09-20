#'Cross-validation for rcar

#'@description Does 10-fold cross-validation for RCAR over an automatically choosen sequence of values of lambda.
#'@param data: A categorical data set with binary response variable; each row is an observation vector.
#'@param y.rank: The rank of the response variable.
#'@param s: A user supplied value for the minimal support of an item set.
#'@param c: A user supplied value for the minimal confidence of class-association rules.
#'@param maxl: A user specified value for the maximal number of items per item set (default: 6 items).
#'@details 10-folds cross validation is calculated over an automatically determined sequence of lambda values ranging from the
#'value of lambda such that all the coefficients are zero down to value of lambda whose the deviance do not change
#'from lambda to the next.
#'Note also that the results of cv.rcar are random, since the folds are selected randomly.
#'Users can reduce this randomness by running cv.rcar many times, and averaging the error curves.
#'@return An object of class "cv.rcar" is returned, which is a list with the ingredients of the cross-validation fit plus the elements of the most accurate model.
#'@export

cv.rcar<-function(data, y.rank=1, s=0.3, c=0.7, maxl=6){
  attach(data,warn.conflicts=FALSE)
  y.levels<-levels(data[[y.rank]])
  oldw<-getOption("warn")
  options(warn=-1)
  rules<- arules::apriori(data,parameter = list(minlen=2,maxlen=maxl, supp=s, conf=c),appearance = list(rhs=paste(colnames(data)[[y.rank]], y.levels, sep="="),default="lhs"),control=list(verbose=FALSE))
  options(warn=oldw)
  r <- as(rules@lhs,"itemMatrix")
  D<-as(data,"transactions")
  X<-arules::is.superset(D,r)
  nr<-rules@lhs@data@Dim[[2]]
  dimnames(X) <- list(NULL, paste("rule", c(1:nr), sep=""))
  cv.out =glmnet::cv.glmnet(X,data[[y.rank]],family="binomial",type.measure="class",alpha =1)
  bestlam =cv.out$lambda.min
  coeff<-predict(cv.out, s=bestlam, type="coefficients")
  retained<-predict(cv.out, s=bestlam, type="nonzero")
  parameter<-data.frame(Support=s, Confidence=c, "Max Length of rules"=maxl)
  Optimal.model=list(Best.lambda=bestlam,Accuracy=1-cv.out$ cvm[cv.out$ lambda==cv.out$lambda.min], RetainedCARs=rules[retained[[1]]],Intercept=coeff[1], coefficients=as.data.frame(cbind(as(as(rules[retained[[1]]]@lhs,"transactions"),"data.frame"),coef=coeff@ x[-1])))
  RCAR.model<-list(Rules= rules, Model.fit=cv.out,Accurate.Model=Optimal.model)
}
