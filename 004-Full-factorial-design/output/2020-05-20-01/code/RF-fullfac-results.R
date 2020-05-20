
RF.fullfc.results <- function(
    DF.input            = NULL,
    Design              = NULL,
    retained.predictors = NULL,
    classes             = NULL
    ) {

    this.function.name <- "RF.fullfc.results";
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
    cat(paste0("\n### full factorial Design: ","\n"));
    # DF.input[,"income_year"] <- as.factor(DF.input[,"income_year"]);
    # labels              <- unique(DF.input[,"income_year"]);

    # DF.input[,ncol(DF.input)] <- as.factor(DF.input[,ncol(DF.input)])
    # classes <- unique(DF.input[,ncol(DF.input)])


    #print(table(DF.input[,ncol(DF.input)]))

    # cat("\n print(levels(income_year) )\n");
    # print( levels(DF.input[,"income_year"])  );

    
    #DoE.RF.results  <- data.frame()
    #results5 <- c()
    
    #DoE.RF.results  <- c();
    fullfc.RF.train <- c();
    fullfc.RF.valid <- c();
    #fullfc.RF.test  <- c();

    for (i in 1:nrow(Design)){
        if (Design$nodesize[i] == -1)  {nodesize <- 1} else {nodesize <- floor(0.1*n.rows)}
        if (Design$classwt[i] == -1)   {classwt <- c(1,10)} else {classwt <- c(10,1)}
        if (Design$cutoff[i] == -1)    {cutoff <- c(0.2,0.8)} else {cutoff <- c(0.8,0.2)}
        if (Design$maxnodes[i] == -1)  {maxnodes <- 5} else {maxnodes <- NULL}
  
  
    #innerResults <- c()

    # TP   <-  0
    # FN   <-  0
    # FP   <-  0
    # TN   <-  0

    RF.results.train <- c()
    RF.results.valid <- c()
    #RF.results.test  <- c()
    #results6 <- c()
    for (j in 1:10){
        print(paste("fold",j,"of run", i))
        # train <- DF.input[-which(randomIndex == j),]
        # test <-  DF.input[ which(randomIndex == j),]

        # cat("\n print(train.levels(income_year) )\n");
        # print( levels(train[,"income_year"])  );

        # print(table(train[,ncol(train)]))
        # print(table(test[,ncol(test)]))


        crossvalidate.res <- cross.validation(
            DF.input = DF.input,
            k        = j);

        train      = crossvalidate.res[["DF.train"]];
        validation = crossvalidate.res[["DF.valid"]];
        #test       = crossvalidate.res[["DF.test"]];

    # RFmodel <- randomForest::randomForest(x = train[,retained.predictors], y = train[,"income_year"],
    #                         xtest = test[,retained.predictors], ytest = test[,"income_year"],
    #                         ntree = ntree,
    #                         mtry = mtry,
    #                         replace = replace,
    #                         nodesize = nodesize,
    #                         classwt = classwt,
    #                         cutoff = cutoff,
    #                         maxnodes = maxnodes)


    RF.machine   <-  randomForest::randomForest(
        x        = train[,retained.predictors],
        y        = train[,"income_year"],
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

    # #confusion.train = as.table(confusionMatrix(predictions.train,train[,"income_year"]));
    # #confusion.valid = as.table(confusionMatrix(predictions.validation, validation[,"income_year"]));
    # confusion.test  = as.table(confusionMatrix(predictions.test, test[,"income_year"]));



    # confusion.test <- as.data.frame(RFmodel$test$confusion)

    # TP   <-  TP + confusion.test[labels[2], labels[2]]
    # FN   <-  FN + confusion.test[labels[2], labels[1]]
    # FP   <-  FP + confusion.test[labels[1], labels[2]]
    # TN   <-  TN + confusion.test[labels[1], labels[1]]

    # TPR <- TP/(TP+FN)
    # TNR <- TN/(TN+FP)
    # BACC <- (TPR + TNR)/2
    # print(BACC)
    # test.RF.results <- rbind(test.RF.results, BACC)

    # TPR <- TP/(TP+FN)
    # TNR <- TN/(TN+FP)
    # BACC <- (TPR + TNR)/2
    # print(BACC)
    # test.RF.results <- c(test.RF.results, BACC)
    RF.results.train <- c(RF.results.train, bacc.train)
    RF.results.valid <- c(RF.results.valid, bacc.valid)
    #RF.results.test  <- c(RF.results.test, bacc.test)
  }

    cat("\n print(RF.results.valid)\n");
    print( RF.results.valid );
    # cat("\n print(results6)\n");
    # print( results6);


    # mean.bacc <- mean(results6)
    # print(mean.bacc)
    # results5 <- c(results5, mean.bacc)


     #mean.BACC      <- mean(as.data.frame(test.RF.results));
     mean.bacc.train     <- mean(RF.results.train);
     mean.bacc.valid     <- mean(RF.results.valid);
     #mean.bacc.test      <- mean(RF.results.test);

     cat("\n print(mean.bacc.valid )\n");
     print( mean.bacc.valid  );

     fullfc.RF.train  <- c(fullfc.RF.train, mean.bacc.train)
     fullfc.RF.valid  <- c(fullfc.RF.valid, mean.bacc.valid)
     #fullfc.RF.test   <- c(fullfc.RF.test, mean.bacc.test)
    # DoE.RF.results <- rbind(DoE.RF.results, mean.BACC)

    # TPR <- TP/(TP+FN)
    # TNR <- TN/(TN+FP)
    # BACC <- (TPR + TNR)/2
    # print(BACC)
    # DoE.RF.results <- c(DoE.RF.results, BACC)

}

#fullfc.results <- add.response(Design, DoE.RF.results)
#fullfc.results <- add.response(Design, results5)

    fullfc.results.train <- add.response(Design, fullfc.RF.train);
    fullfc.results.valid <- add.response(Design, fullfc.RF.valid);
    #fullfc.results.test <- add.response(Design, fullfc.RF.test);


    cat("\n print(summary(fullfc.results.train))\n");
    print( summary(fullfc.results.train) );


    cat("\n print(summary(fullfc.results.valid))\n");
    print( summary(fullfc.results.valid) );


# write.csv(
# x         = fullfc.results,
# file      = "RFDOE.csv",
# row.names = FALSE)

#save(design.resp, file = "RFDOE.RData")

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-full-factorial-train-",".png"));
    MEPlot(
        obj   = fullfc.results.train,
        # abbrev   = 5,
        cex.xax  = 1.4,
        cex.main = 1.5,
        main    = "Main effects plot for full factorial design train data");

     dev.off();

     png(paste0("plot-","interactions-full-factorial-train-",".png"));
     IAPlot(
         obj = fullfc.results.train,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main = 1.5,
         # lwd = 2,
         # cex = 1.5,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "Interactionsplot for full Factorial Design train data");

     dev.off();
     ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-full-factorial-valid-",".png"));
    MEPlot(
        obj   = fullfc.results.valid,
        # abbrev   = 5,
        cex.xax  = 1.4,
        cex.main = 1.5,
        main    = "Main effects plot for full factorial design validation data");

     dev.off();

     png(paste0("plot-","interactions-full-factorial-valid-",".png"));
     IAPlot(
         obj = fullfc.results.valid,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main = 1.5,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "Interactionsplot for full Factorial Design validation data");

     dev.off();
     ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    # png(paste0("plot-","main-effects-full-factorial-test-",".png"));
    # MEPlot(
    #     obj   = fullfc.results.test,
    #     # abbrev   = 5,
    #     cex.xax  = 1.4,
    #     cex.main = 1.5,
    #     main    = "Main effects plot for full factorial design test data");

    #  dev.off();

    #  png(paste0("plot-","interactions-full-factorial-test-",".png"));
    #  IAPlot(
    #      obj = fullfc.results.test,
    #      # abbrev = 5,
    #      show.alias = TRUE,
    #      cex.main = 1.5,
    #      # lwd = 2,
    #      # cex = 2,
    #      # cex.xax = 1.2,
    #      # cex.lab = 1.5,
    #      main = "Interactionsplot for full Factorial Design test data");

    #  dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( list(
        DF.fullfc.train = fullfc.results.train,
        DF.fullfc.valid = fullfc.results.valid))
        #DF.fullfc.test  = fullfc.results.test) );

    }
