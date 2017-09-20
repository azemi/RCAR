#'make classification from a "rcar" object.

#'@description This function gives the predicted class of a new data records from a fitted "rcar" object.
#'@import arules
#'@importFrom glmnet glmnet
#'@importFrom arules apriori
#'@importFrom arules inspect
#'@param object: Fitted "rcar" model object..
#'@param y.rank: Matrix of new values for x at which classification is to be made.
#'@return The predicted classes using "rcar" object.
#'@examples
#'
#'nrow(vote)
#'set.seed(1)
#'train<-sample(232,202)
#'vote.train<- vote[train,]
#'vote.test <-vote[-train,]
#'
#'Select a random subset of 202 observations out of the original 232 observations in vote dataset,
#'the selected sample will be used to train the "rcar" oject, while the rest will be used to estimate the test error.
#'
#'
#'vote.cv<-cv.rcar(vote.train, y.rank = 1, s=0.2, c=0.8)
#'best.lambda<-vote.cv$Accurate.Model$Best.lambda
#'
#'Use 10-folds-cross-validation to get lambda that gives the minimum mean cross-validated error.
#'
#'
#'vote.racar<-rcar(vote.train, y.rank = 1, s=0.2, c=0.8,lambd=best.lambda)
#'vote.pred<-predict.rcar(vote.racar,vote.test)
#'
#'Predicted classes of the test sample are calculated using "rcar" object coresponding to best.lambda.
#'
#'table(vote$Class.Name[-train], vote.pred)
#'
#'
#'@export


predict.rcar<-function(object, newdata){
  if(length(object[[2]]$lambda)>1){
    return("specify the value of lambda when building the model")
  } else
  rules.space<-as(object[[1]]@lhs,"itemMatrix")
  D<-as(newdata,"transactions")
  X<-arules::is.superset(D,rules.space)
  dimnames(X) <- list(NULL, paste("rule", c(1:object[[1]]@lhs@data@Dim[[2]]), sep=""))
  predict(object[[2]], newx=X, type="class")
}

