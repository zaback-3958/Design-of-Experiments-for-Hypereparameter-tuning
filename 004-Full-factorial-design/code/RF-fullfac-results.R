
RF.fullfac.results <- function(
    DF.input            = NULL,
    Design              = NULL,
    retained.predictors = NULL,
    classes             = NULL,
    nFactors            = NULL
    ) {

    this.function.name <- "RF.fullfac.results";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(randomForest);
    require(DoE.base);
    require(FrF2);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    n.rows <- nrow(DF.input);
    print(n.rows)
    n.cols <- ncol(DF.input);
    print(n.cols)
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0(" \n full factorial Design:","n=",nFactors ,"\n"));
    

    fullfc.RF.train <- c();
    fullfc.RF.valid <- c();
    #fullfc.RF.test  <- c();

    for (i in 1:nrow(Design)){
        if (Design$nodesize[i] == -1)  {nodesize <- 1} else {nodesize <- floor(0.1*n.rows)}
        if (Design$classwt[i] == -1)   {classwt <- c(1,10)} else {classwt <- c(10,1)}
        if (Design$cutoff[i] == -1)    {cutoff <- c(0.2,0.8)} else {cutoff <- c(0.8,0.2)}
        if (Design$maxnodes[i] == -1)  {maxnodes <- 5} else {maxnodes <- NULL}
  
 
    RF.results.train <- c()
    RF.results.valid <- c()
    #RF.results.test  <- c()

    for (j in 1:10){
        print(paste("fold",j,"of run", i))
   

        crossvalidate.res <- cross.validation(
            DF.input = DF.input,
            k        = j);

        train      = crossvalidate.res[["DF.train"]];
        validation = crossvalidate.res[["DF.valid"]];


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

        bacc.train <- DF.bacc[["bacc.train"]]
        bacc.valid <- DF.bacc[["bacc.valid"]]
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

     fullfc.RF.train  <- c(fullfc.RF.train, mean.bacc.train)
     fullfc.RF.valid  <- c(fullfc.RF.valid, mean.bacc.valid)
     #fullfc.RF.test   <- c(fullfc.RF.test, mean.bacc.test)
 }

    fullfc.results.train <- add.response(Design, fullfc.RF.train);
    fullfc.results.valid <- add.response(Design, fullfc.RF.valid);
    #fullfc.results.test <- add.response(Design, fullfc.RF.test)

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
    png(paste0("plot-","main-effects-full-factorial-train",".png"));
    MEPlot(
        obj      = fullfc.results.train,
        # abbrev   = 5,
        cex.xax  = 1.4,
        cex.main = 1.5,
        main     = "Main effects plot for full factorial design train data");

     dev.off();

     png(paste0("plot-","interactions-full-factorial-train-",".png"));
     IAPlot(
         obj        = fullfc.results.train,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main   = 1.5,
         # lwd = 2,
         # cex = 1.5,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main       = "Interactionsplot for full Factorial Design train data");

     dev.off();
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-full-factorial-valid-",".png"));
    MEPlot(
        obj      = fullfc.results.valid,
        # abbrev   = 5,
        cex.xax  = 1.4,
        cex.main = 1.5,
        main     = "Main effects plot for full factorial design validation data");

     dev.off();

     png(paste0("plot-","interactions-full-factorial-valid-",resolution,".png"));
     IAPlot(
         obj        = fullfc.results.valid,
         # abbrev = 5,
         show.alias = TRUE,
         cex.main   = 1.5,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main       = "Interactionsplot for full Factorial Design validation data");

     dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( list(
        DF.fullfc.train = fullfc.results.train,
        DF.fullfc.valid = fullfc.results.valid))
        #DF.fullfc.test = fullfc.results.test));

    }
