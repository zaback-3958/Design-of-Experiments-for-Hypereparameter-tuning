
RF.bbdes.results <- function(
    DF.input            = NULL,
    Design              = NULL,
    retained.predictors = NULL,
    classes             = NULL
    ) {
        this.function.name <- "RF.bbdes.results";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(randomForest);
    require(FrF2);
    require(caret);
    require(e1071);
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    n.rows <- nrow(DF.input);
    print(n.rows)
    n.cols <- ncol(DF.input);
    print(n.cols)
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\n### bbdes Design: ","\n"));
    
    bbdes.RF.train <- c();
    bbdes.RF.valid <- c();
    #bbdes.RF.test  <- c();

    cat("\ print(Design )\n");
    print( print(Design)   );

    for (i in 1:nrow(Design)){
        print(as.data.frame(Design[i,c('x1','x2','x3')]))
        if (Design$x1[i] == -1)   {nodesize <- 3}
        if (Design$x1[i] ==  0)   {nodesize <- 6}
        if (Design$x1[i] ==  1)   {nodesize <- 9}

        if (Design$x2[i] == -1)   {classwt <- c(8,1)}
        if (Design$x2[i] ==  0)   {classwt <- c(10,1)}
        if (Design$x2[i] ==  1)   {classwt <- c(12,1)}

        if (Design$x3[i] == -1)    {cutoff <- c(0.75, 1- 0.75)}
        if (Design$x3[i] ==  0)    {cutoff <- c(0.80, 1 -0.80)}
        if (Design$x3[i] ==  1)    {cutoff <- c(0.85, 1 -0.85)}

    RF.results.train <- c()
    RF.results.valid <- c()
    #RF.results.test  <- c()
    #results6 <- c()
    for (j in 1:10){
        print(paste("fold",j,"of run", i))
        
        crossvalidate.res <- cross.validation(
            DF.input = DF.input,
            k        = j);

        train      = crossvalidate.res[["DF.train"]];
        validation = crossvalidate.res[["DF.valid"]];
        #test       = crossvalidate.res[["DF.test"]];

    # RF.machine   <-  randomForest::randomForest(
    #     x           = train[,retained.predictors],
    #     y           = train[,"income_year"],
    #     nodesize    = nodesize,
    #     classwt     = classwt,
    #     cutoff      = cutoff,
    #     keep.forest = T);
 
    RF.machine <- randomForest(x = train[,1:ncol(train)-1], y = train[,ncol(train)],
                            nodesize = nodesize,
                            classwt = classwt,
                            cutoff = cutoff,
                            keep.forest = T)

    predictions.train <- predict(
        object  = RF.machine,
        newdata = train[,retained.predictors]);


    predictions.validation <- predict(
        object  = RF.machine,
        newdata = validation[,retained.predictors]);

    # predictions.test <- predict(
    #     object  = RF.machine,
    #     newdata = test[,retained.predictors]);


    DF.bacc <- bacc.measure.func(
        DF.train           = train,
        DF.validation      = validation,
        #DF.test            = test,
        DF.pred.train      = predictions.train,
        DF.pred.validation = predictions.validation,
        #DF.pred.test       = predictions.test,
        classes            = classes)

        bacc.train <- DF.bacc[["DF.bacc.train"]]
        bacc.valid <- DF.bacc[["DF.bacc.valid"]]
        #bacc.test  <- DF.bacc[["DF.bacc.test"]]

    RF.results.train <- c(RF.results.train, bacc.train)
    RF.results.valid <- c(RF.results.valid, bacc.valid)
    #RF.results.test  <- c(RF.results.test, bacc.test)
  }

    cat("\n print(RF.results.valid)\n");
    print( RF.results.valid );
   
     mean.bacc.train     <- mean(RF.results.train);
     mean.bacc.valid     <- mean(RF.results.valid);
     #mean.bacc.test      <- mean(RF.results.test);

     cat("\n print(mean.bacc.valid )\n");
     print( mean.bacc.valid  );

     bbdes.RF.train  <- c(bbdes.RF.train, mean.bacc.train)
     bbdes.RF.valid  <- c(bbdes.RF.valid, mean.bacc.valid)
     #bbdes.RF.test   <- c(bbdes.RF.test, mean.bacc.test)

     cat("\n print(bbdes.RF.valid )\n");
     print( bbdes.RF.valid  );
    
}

    #design$response <- results5
    Design$response_train <- bbdes.RF.train
    bbdes.results.train <- Design;

    Design <- Design[,1:ncol(Design)-1]

    cat("\n print(Design))\n");
    print( Design );


    Design$response_valid <- bbdes.RF.valid
    bbdes.results.valid <- Design;

    #Design <- Design[,1:ncol(Design)-1]

    # bbdes.results.train <- c(Design, bbdes.RF.train);
    # bbdes.results.valid <- c(Design, bbdes.RF.valid);
    #bbdes.results.test <- add.response(Design, bbdes.RF.test)

    cat("\n print(Design))\n");
    print( Design );

    cat("\n print(bbdes.results.valid))\n");
    print( bbdes.results.valid );


    # cat("\n print(summary(bbdes.results.train))\n");
    # print( summary(bbdes.results.train) );


    # cat("\n print(summary(bbdes.results.valid))\n");
    # print( summary(bbdes.results.valid) );


# write.csv(
# x         = bbdes.results,
# file      = "RFDOE.csv",
# row.names = FALSE)

#save(Design.resp, file = "RFDOE.RData")

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( list(
        DF.bbdes.train = bbdes.results.train,
        DF.bbdes.valid = bbdes.results.valid))
        #DF.bbdes.test  = bbdes.results.test) );
    }
