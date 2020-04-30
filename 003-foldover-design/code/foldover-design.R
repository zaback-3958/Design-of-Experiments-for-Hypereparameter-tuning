
foldover.design <- function(
    DF.input            = NULL,
    Design              = NULL,
    retained.predictors = NULL,
    classes             = NULL,
    resolution          = NULL
    ) {

    this.function.name <- "foldover.design";
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
    cat(paste0("\n### Fractional Design: ",resolution,"\n"));
    
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\n print(summary(Design) )\n");
    print( summary(Design)  );

    cat("\n print(design.info(Design) )\n");
    print( design.info(Design) );

    foldDesign <- fold.design(Design)

    cat("\n print(foldDesign )\n");
    print( foldDesign  );

    cat("\n print(summary(foldDesign) )\n");
    print( summary(foldDesign)  );

    cat("\n print(design.info(foldDesign) )\n");
    print( design.info(foldDesign) );

    
    frfc.RF.train <- c();
    frfc.RF.valid <- c();
    frfc.RF.test  <- c();

    for (i in 1:nrow(Design)){
        if (Design$ntree[i] == -1)     {ntree <- 100} else {ntree <- 500}
        if (Design$mtry[i] == -1)      {mtry <- floor(log(n.cols-1))} else {mtry <- ceiling(sqrt(n.cols-1))}
        if (Design$replace[i] == -1)   {replace <- FALSE} else {replace <- TRUE}
        if (Design$nodesize[i] == -1)  {nodesize <- 1} else {nodesize <- floor(0.1*n.rows)}
        if (Design$classwt[i] == -1)   {classwt <- c(1,10)} else {classwt <- c(10,1)}
        if (Design$cutoff[i] == -1)    {cutoff <- c(0.2, 1 -0.2)} else {cutoff <- c(0.8,1 -0.8)}
        if (Design$maxnodes[i] == -1)  {maxnodes <- 5} else {maxnodes <- NULL}


    RF.results.train <- c()
    RF.results.valid <- c()
    RF.results.test  <- c()
    #results6 <- c()
    for (j in 1:10){
        print(paste("fold",j,"of run", i))
        
        crossvalidate.res <- cross.validation(
            DF.input = DF.input,
            k        = j);

        train      = crossvalidate.res[["DF.train"]];
        validation = crossvalidate.res[["DF.valid"]];
        test       = crossvalidate.res[["DF.test"]];

    RF.machine   <-  randomForest::randomForest(
        x        = train[,retained.predictors],
        y        = train[,"income_year"],
        ntree    = ntree,
        mtry     = mtry,
        replace  = replace,
        nodesize = nodesize,
        classwt  = classwt,
        cutoff   = cutoff,
        maxnodes = maxnodes);
 

    predictions.train <- predict(
        object  = RF.machine,
        newdata = train[,retained.predictors]);

    predictions.validation <- predict(
        object  = RF.machine,
        newdata = validation[,retained.predictors]);

    predictions.test <- predict(
        object  = RF.machine,
        newdata = test[,retained.predictors]);


    DF.bacc <- bacc.measure.func(
        DF.train           = train,
        DF.validation      = validation,
        DF.test            = test,
        DF.pred.train      = predictions.train,
        DF.pred.validation = predictions.validation,
        DF.pred.test       = predictions.test,
        classes            = classes)

        bacc.train <- DF.bacc[["DF.bacc.train"]]
        bacc.valid <- DF.bacc[["DF.bacc.valid"]]
        bacc.test  <- DF.bacc[["DF.bacc.test"]]

   
    RF.results.train <- c(RF.results.train, bacc.train)
    RF.results.valid <- c(RF.results.valid, bacc.valid)
    RF.results.test  <- c(RF.results.test, bacc.test)
  }

    cat("\n print(RF.results.test)\n");
    print( RF.results.test );
    
    
     mean.bacc.train     <- mean(RF.results.train);
     mean.bacc.valid     <- mean(RF.results.valid);
     mean.bacc.test      <- mean(RF.results.test);

     cat("\n print(mean.bacc.test )\n");
     print( mean.bacc.test  );

     frfc.RF.train  <- c(frfc.RF.train, mean.bacc.train)
     frfc.RF.valid  <- c(frfc.RF.valid, mean.bacc.valid)
     frfc.RF.test   <- c(frfc.RF.test, mean.bacc.test)
    
}


    frfc.results.train <- add.response(Design, frfc.RF.train);
    frfc.results.valid <- add.response(Design, frfc.RF.valid);
    frfc.results.test <- add.response(Design, frfc.RF.test)



    cat("\n print(summary(frfc.results.test))\n");
    print( summary(frfc.results.test) );


# write.csv(
# x         = frfc.results,
# file      = "RFDOE.csv",
# row.names = FALSE)

#save(design.resp, file = "RFDOE.RData")

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-train-",resolution,".png"));
    MEPlot(
        obj   = frfc.results.train,
        # abbrev   = 5,
        cex.xax  = 1.6,
        cex.main = 1.2,
        main    = "Main effects plot for fractional factorial design train data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-train-",resolution,".png"));
     IAPlot(
         obj = frfc.results.train,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main = 1.2,
         # lwd = 2,
         # cex = 1.5,
         cex.xax = 1.6,
         # cex.lab = 1.5,
         main = "Interactionsplot for Fractional Factorial Design train data");

     dev.off();
     ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-valid-",resolution,".png"));
    MEPlot(
        obj   = frfc.results.valid,
        # abbrev   = 5,
        cex.xax  = 1.6,
        cex.main = 1.2,
        main    = "Main effects plot for fractional factorial design validation data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-valid-",resolution,".png"));
     IAPlot(
         obj = frfc.results.valid,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main = 1.2,
         # lwd = 2,
         # cex = 2,
         cex.xax = 1.6,
         # cex.lab = 1.5,
         main = "Interactionsplot for Fractional Factorial Design validation data");

     dev.off();
     ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-test-",resolution,".png"));
    MEPlot(
        obj   = frfc.results.test,
        # abbrev   = 5,
        cex.xax  = 1.6,
        cex.main = 1.2,
        main    = "Main effects plot for fractional factorial design test data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-test-",resolution,".png"));
     IAPlot(
         obj = frfc.results.test,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main = 1.2,
         # lwd = 2,
         # cex = 2,
         cex.xax = 1.6,
         # cex.lab = 1.5,
         main = "Interactionsplot for Fractional Factorial Design test data");

     dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( list(
        DF.frfc.train = frfc.results.train,
        DF.frfc.valid = frfc.results.valid,
        DF.frfc.test  = frfc.results.test) );

    }
