
cross.validation <- function(
    DF.input = NULL,
    k        = NULL) {


	this.function.name <- "cross.validation";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    require(caret);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    #cross-validation
    createInd = rep(1:10, length.out = nrow(DF.input))
    randomInd = sample(createInd)
  
    trainset = DF.input[-which(randomInd == k),]
    train    = DF.input[-which(randomInd == k),]
    test     = DF.input[ which(randomInd == k),]
  
  
    validationInd = sample(1:nrow(trainset), size = round(0.75*nrow(trainset)), replace=FALSE)
    train         = trainset[validationInd,]
    validation    = trainset[-validationInd,]


 #    cat("\n str(train)\n");
	# print(str(train ));
    
 #    cat("\n str(validation)\n");
	# print( str(validation )); 

    # cat("\n str(test)\n");
    # print(str(test )); 
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    
    return( list(
    DF.train = train,
    DF.valid = validation,
    DF.test  = test ))

    }
