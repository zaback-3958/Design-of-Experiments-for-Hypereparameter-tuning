
fmeasure.func <- function(
	DF.train           = NULL,
	DF.validation      = NULL,
	DF.test            = NULL,
	DF.pred.train      = NULL,
	DF.pred.validation = NULL,
	DF.pred.test       = NULL,
	classes            = NULL
	) {

	this.function.name <- "fmeasure.func";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);
    require(caret);
    require(e1071);

	###################################################

	confusion.train = as.table(confusionMatrix(DF.pred.train,DF.train[,"my_res"]));
	confusion.valid = as.table(confusionMatrix(DF.pred.validation, DF.validation[,"my_res"]));
	confusion.test  = as.table(confusionMatrix(DF.pred.test, DF.test[,"my_res"]));


	confmtrx.train = confusion.mtrx(DF.input = confusion.train,classes = classes)
  	confmtrx.valid = confusion.mtrx(DF.input = confusion.valid,classes = classes)
  	confmtrx.test  = confusion.mtrx(DF.input = confusion.test,classes = classes)

  
  	recal.train = recal.fnc(DF.input = confmtrx.train)
  	recal.valid = recal.fnc(DF.input = confmtrx.valid)
  	recal.test  = recal.fnc(DF.input = confmtrx.test)

  	cat("\n print(recal.train)\n");
    print( recal.train );

    cat("\n print(recal.valid)\n");
    print( recal.valid );

    cat("\n print(recal.test)\n");
    print( recal.test );
  
  	precs.train = precision.fnc(DF.input = confmtrx.train)
  	precs.valid = precision.fnc(DF.input = confmtrx.valid)
  	precs.test  = precision.fnc(DF.input = confmtrx.test)

  	cat("\n print(precs.train)\n");
    print( precs.train );

    cat("\n print(precs.valid)\n");
    print( precs.valid );

    cat("\n print(precs.test)\n");
    print( precs.test );
  
  	f.measure.train = fmeasure.fnc(DF.recal = recal.train,DF.precision = precs.train)
  	f.measure.valid = fmeasure.fnc(DF.recal = recal.valid,DF.precision = precs.valid)
  	f.measure.test  = fmeasure.fnc(DF.recal = recal.test,DF.precision = precs.test)
  
  	cat("\n print(f.measure.train)\n");
    print( f.measure.train );

    cat("\n print(f.measure.valid)\n");
    print( f.measure.valid );

    cat("\n print(f.measure.test)\n");
    print( f.measure.test );


	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( list(
	    DF.fmtrain = f.measure.train,
	    DF.fmvalid = f.measure.valid,
	    DF.fmtest  = f.measure.test));

	}

####################################################
	confusion.mtrx <- function(
		DF.input = NULL,
		classes  = NULL){
			TP   <-  0;
			FN   <-  0;
			FP   <-  0;
			TN   <-  0;

			TP = TP + DF.input[classes[2], classes[2]];
			FN = FN + DF.input[classes[2], classes[1]];
			FP = FP + DF.input[classes[1], classes[2]];
			TN = TN + DF.input[classes[1], classes[1]]

  	return(list(
	  	n.tp = TP,
	  	n.fn = FN,
	  	n.fp = FP,
	  	n.tn = TN));

}

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	recal.fnc <- function(
		DF.input = NULL){
			recallfunc = DF.input[["n.tp"]]/(DF.input[["n.tp"]]+ DF.input[["n.fn"]])
		return(recallfunc)
}
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	precision.fnc <- function(
		DF.input = NULL){
			precisionfunc = DF.input[["n.tp"]]/(DF.input[["n.tp"]]+ DF.input[["n.fn"]])
			return(precisionfunc)
}
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	fmeasure.fnc <- function(
		DF.recal     = NULL,
		DF.precision = NULL){
			fmeasurefunc = (2*DF.recal*DF.precision)/(DF.precision + DF.recal)

  return(fmeasurefunc)
  
}



