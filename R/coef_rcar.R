#'Coefficients extraction from "rcar" or "cv.rcar" object

#'@description This functions extracts coefficients from a "rcar" or "cv.rcar" object at a single value of lambda.
#'@param object: "rcar" or "cv.rcar" object.
#'@param lambd: Value of the penalty parameter lambda at which coefficients extraction is required. If not specified, the programme use the value of lambda corresponding the minimum mean cross-validated error.
#'@return The function returns the retained rules and their corresponding parameters.

#'@examples
#'
#'vote.rcar.1<-rcar(vote, y.rank = 1, s=0.2, c=0.8,lambd=0.169)
#'vote.rcar.2<-rcar(vote, y.rank = 1, s=0.2, c=0.8)
#'
#'coef.rcar(vote.rcar.1)
#'coef.rcar(vote.rcar.2, lambd = 0.169)
#'
#'
#'vote.cv<-cv.rcar(vote, y.rank = 1, s=0.2, c=0.8)
#'
#'coef.rcar(vote.cv, lambd=0.169)
#'coef.rcar(vote.rcar)
#'If the value of lambda is not specified, the programme uses the value of lambda corresponding the minimum mean cross-validated error.
#'
#'@export

coef.rcar<-function(object,lambd){
  oldw<-getOption("warn")
  options(warn=-1)
  if(length(object)==2){
    {
      if (length(object[[2]]$lambda)==1){lambd<-object[[2]]$lambda}
      else if(missing(lambd)){return("argument lambd is missing")}

    }
  rules.mod<-object[[1]]@lhs[c(coef(object[[2]], s=lambd)@ i)]
  rules.mod<-rbind("",as(as(rules.mod,"transactions"),"data.frame"))
  rownames(rules.mod)<-c("Intercept", paste("rules", c(coef(object[[2]], s=lambd)@ i[-1]-1), sep=""))
  coeff<-as(cbind(rules.mod,as.data.frame(coef(object[[2]], s=lambd)[coef(object[[2]], s=lambd)!=0])),"data.frame")
  colnames(coeff)<-c("rules","coefficients")
  coeff<-as(coeff,"data.frame") }
  else if (length(object)==3){
  ifelse(missing(lambd),lambd<-object$Model.fit$lambda.min,lambda<-lambd)
  coeff<-predict(object$Model.fit, s=lambd, type="coefficients")
  retained<-predict(object$Model.fit, s=lambd, type="nonzero")
  coeff=list(Lambda=lambd,Accuracy=1-object$Model.fit$cvm[object$Model.fit$ lambda==object$Model.fit$lambda.min], RetainedCARs=object$Rules[retained[[1]]],Intercept=coeff[1], coefficients=as.data.frame(cbind(as(as(object$Rules[retained[[1]]]@lhs,"transactions"),"data.frame"),coef=coeff@ x[-1])))
  }
  options(warn=oldw)
  coeff
}
