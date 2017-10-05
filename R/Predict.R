#'make classification from a "rcar" object.

#'@description This function gives the predicted class of a new data records from a "rcar" or "cv.rcar" object at a single value of lambda.
#'@import arules
#'@importFrom glmnet glmnet
#'@importFrom arules apriori
#'@importFrom arules inspect
#'@param object: Fitted "rcar" or "cv.rcar" object.
#'@param newdata: Matrix of new values for x at which predictions are to be made. Must be a matrix; can be sparse as in Matrix package.
#'@return The predicted classes using RCAR approach.
#'@examples
#'
#'Vote<-na.omit(Vote)
#'nrow(Vote)
#'set.seed(1)
#'train<-sample(232,202)
#'vote.train<- vote[train,]
#'vote.test <-vote[-train,]
#'
#'Select a random subset of 202 observations out of the original 232 observations in vote dataset,
#'the selected sample will be used to train the "rcar" and "cv.rcar" ojects, while the rest will be used to estimate the test error.
#'
#'
#'vote.cv<-cv.rcar(vote.train, y.rank = 1, s=0.2, c=0.8)
#'best.lambda<-vote.cv$Accurate.Model$Best.lambda
#'
#'vote.pred<-predict.rcar(vote.cv,vote.test) #While the lambd, value of lambda, is not specified, the programme uses the value of lambda corresponding the minimum mean cross-validated error.
#'table(vote$Class.Name[-train], vote.pred)
#'
#'vote.pred<-predict.rcar(vote.cv,vote.test, lambd = 0) #] predicted value with lambda=0
#'table(vote$Class.Name[-train], vote.pred)
#'
#'
#'vote.racar<-rcar(vote.train, y.rank = 1, s=0.2, c=0.8,lambd=best.lambda)
#'vote.pred<-predict.rcar(vote.racar,vote.test)
#'table(vote$Class.Name[-train], vote.pred)
#'
#'
#'@export


predict.rcar<-function(object, newdata,lambd){
  oldw<-getOption("warn")
  options(warn=-1)

  rules.space<-as(object[[1]]@lhs,"itemMatrix")
  D<-as(newdata,"transactions")
  X<-arules::is.superset(D,rules.space)
  dimnames(X) <- list(NULL, paste("rule", c(1:dim(X)[[2]]), sep=""))

  if(length(object)==2){
    {if (length(object[[2]]$lambda)==1){lambd<-object[[2]]$lambda}
      else if(missing(lambd)){return("argument lambd is missing")}}
    predicted.classes<-predict(object[[2]], newx=X, s=lambd, type="class") }

  else if (length(object)==3){
    if(missing(lambd)) {lambd<-object$Model.fit$lambda.min}
    predicted.classes<-predict(object[[2]], newx=X, s=lambd, type="class")
    }
  options(warn=oldw)
  predicted.classes
}
