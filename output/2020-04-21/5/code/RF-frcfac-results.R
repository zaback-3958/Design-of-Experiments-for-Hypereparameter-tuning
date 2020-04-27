
RF.frcfac.results <- function(
    DF.input            = NULL,
    Design              = NULL,
    crossvalidset       = NULL,
    retained.predictors = NULL,
    resolution          = NULL,
    classes             = NULL
    ){
        this.function.name <- "RF.frcfac.results";
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
    cat(paste0(" \n Fractional Design:","resolution=",resolution ,"\n"));

    # DF.input[,"my_res"] <- as.factor(DF.input[,"my_res"]);
    # labels              <- unique(DF.input[,"my_res"]);

    # DF.input[,ncol(DF.input)] <- as.factor(DF.input[,ncol(DF.input)])
    # labels <- unique(DF.input[,ncol(DF.input)])


    # print(table(DF.input[,ncol(DF.input)]))

    # cat("\n print(levels(my_res) )\n");
    # print( levels(DF.input[,"my_res"])  );

    results.train <- data.frame();
    results.valid <- data.frame();
    results.test  <- data.frame();

    frc.results.train <- data.frame();
    frc.results.valid <- data.frame();
    frc.results.test  <- data.frame();

    for (i in 1:nrow(Design)){
        if (Design$ntree[i] == -1)     {ntree <- 100} else {ntree <- 500}
        if (Design$mtry[i] == -1)      {mtry <- floor(log(n.cols-1))} else {mtry <- ceiling(sqrt(n.cols-1))}
        if (Design$replace[i] == -1)   {replace <- FALSE} else {replace <- TRUE}
        if (Design$nodesize[i] == -1)  {nodesize <- 1} else {nodesize <- floor(0.1*n.rows)}
        if (Design$classwt[i] == -1)   {classwt <- c(1,10)} else {classwt <- c(10,1)}
        if (Design$cutoff[i] == -1)    {cutoff <- c(0.2, 0.8)} else {cutoff <- c(0.8,0.2)}
        if (Design$maxnodes[i] == -1)  {maxnodes <- 5} else {maxnodes <- NULL}

  

    for (j in 1:10){
        print(paste("fold",j,"of run", i))

        crossvalidate.res <- cross.validation(
            DF.input = DF.input,
            k        = j)

        train      = crossvalidate.res[["DF.train"]];
        validation = crossvalidate.res[["DF.valid"]];
        test       = crossvalidate.res[["DF.test"]];

        # train <- DF.input[-which(randomInd == j),]
        # test <-  DF.input[ which(randomInd == j),]

        # cat("\n print(train.levels(my_res) )\n");
        # print( levels(train[,"my_res"])  );

        # print(table(train[,ncol(train)]))
        # print(table(test[,ncol(test)]))

    RF.machine   <-  randomForest::randomForest(
        x        = train[,retained.predictors],
        y        = train[,"my_res"],
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

    DF.fmeasure <- fmeasure.func(
        DF.train           = train,
        DF.validation      = validation,
        DF.test            = test,
        DF.pred.train      = predictions.train,
        DF.pred.validation = predictions.validation,
        DF.pred.test       = predictions.test,
        classes            = classes)

    fmeasure.train <- DF.fmeasure[["DF.fmtrain"]]
    fmeasure.valid <- DF.fmeasure[["DF.fmvalid"]]
    fmeasure.test  <- DF.fmeasure[["DF.fmtest"]]

    cat("\n print(fmeasure.test)\n");
    print( fmeasure.test );

    results.train <- c(results.train,fmeasure.train)
    results.valid <- c(results.valid,fmeasure.valid)
    results.test  <- c(results.test,fmeasure.test)

  }
   
    mean.train <- mean(results.train)
    mean.valid <- mean(results.valid)
    mean.test  <- mean(results.test)

    cat("\n print(mean.test)\n");
    print( mean.test );

    frc.results.train <- c(frc.results.train, mean.train)
    frc.results.valid <- c(frc.results.valid, mean.valid)
    frc.results.test  <- c(frc.results.test, mean.test)


}

    frfc.results.train <- add.response(Design, frc.results.train)
    cat("\n print(summary(frfc.results.train))\n");
    print( summary(frfc.results.train) );

    frfc.results.valid <- add.response(Design, frc.results.valid)
    cat("\n print(summary(frfc.results.valid))\n");
    print( summary(frfc.results.valid) );

    frfc.results.test <- add.response(Design, frc.results.test)
    cat("\n print(summary(frfc.results.test))\n");
    print( summary(frfc.results.test) );


# write.csv(
# x         = frfc.results.train,
# file      = "frfc-result-train.csv",
# row.names = FALSE)

#save(design.resp, file = "RFDOE.RData")

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-train-",resolution,".png"));
    MEPlot(obj   = frfc.results.train,
        # abbrev   = 5,
        # cex.xax  = 1.6,
        # cex.main = 2,
        main    = "Main effects plot for fractional factorial design train data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-train-",resolution,".png"));
     IAPlot(obj = frfc.results.train,
         #abbrev = 5,
         show.alias = TRUE,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "InteractionsPplot for Fractional Factorial Design train data");

     dev.off();
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-validation-",resolution,".png"));
    MEPlot(obj   = frfc.results.valid,
        # abbrev   = 5,
        # cex.xax  = 1.6,
        # cex.main = 2,
        main    = "Main effects plot for fractional factorial design validation data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-validation-",resolution,".png"));
     IAPlot(obj = frfc.results.valid,
         #abbrev = 5,
         show.alias = TRUE,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "InteractionsPplot for Fractional Factorial Design validation data");

     dev.off();

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-fractional-factorial-test-",resolution,".png"));
    MEPlot(obj   = frfc.results.test,
        # abbrev   = 5,
        # cex.xax  = 1.6,
        # cex.main = 2,
        main    = "Main effects plot for fractional factorial design test data");

     dev.off();

     png(paste0("plot-","interactions-fractional-factorial-test-",resolution,".png"));
     IAPlot(obj = frfc.results.test,
         #abbrev = 5,
         show.alias = TRUE,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "InteractionsPplot for Fractional Factorial Design test data");

     dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( list(
        DF.frc.train = frc.results.train,
        DF.frc.valid = frc.results.valid,
        DF.frc.test  = frc.results.test))
    }


    