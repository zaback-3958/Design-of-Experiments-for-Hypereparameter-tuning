
RF.fullfac.results <- function(
    DF.input            = NULL,
    Design              = NULL,
    randomIndex         = NULL,
    retained.predictors = NULL,
    nFactors            = NULL
    ) {

    this.function.name <- "RF.fullfac.results";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(randomForest);
    require(DoE.base);
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    n.rows <- nrow(DF.input);
    print(n.rows)
    n.cols <- ncol(DF.input);
    print(n.cols)
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0(" \n full factorial Design:","n=",nFactors ,"\n"));
    # DF.input[,"my_res"] <- as.factor(DF.input[,"my_res"]);
    # labels              <- unique(DF.input[,"my_res"]);

    # DF.input[,ncol(DF.input)] <- as.factor(DF.input[,ncol(DF.input)])
    # labels <- unique(DF.input[,ncol(DF.input)])

    fullfact.results <- c()

    for (i in 1:nrow(des.deo)){
        if (des.deo$nodesize[i] == -1)  {nodesize <- 1} else {nodesize <- floor(0.1*n.rows)}
        if (des.deo$classwt[i] == -1)   {classwt <- c(1,10)} else {classwt <- c(10,1)}
        if (des.deo$cutoff[i] == -1)    {cutoff <- c(0.2,0.8)} else {cutoff <- c(0.8,0.2)}
        if (des.deo$maxnodes[i] == -1)  {maxnodes <- 5} else {maxnodes <- NULL}
  
 
    internalResults <- c()
  
    TP   <-  0
    FN   <-  0
    FP   <-  0
    TN   <-  0
  
    for (j in 1:10){
        print(paste("fold",j,"of run", i))
        train <- DF.input[-which(randomIndex == j),]
        test <-  DF.input[ which(randomIndex == j),]
    
    RFmodel <- randomForest(
        x = train[,retained.predictors],
        y = train[,"my_res"],
        xtest = test[,retained.predictors],
        ytest = test[,"my_res"],
        nodesize = nodesize,
        classwt = classwt,
        cutoff = cutoff,
        maxnodes = maxnodes)
    
    confu <- as.data.frame(RFmodel$test$confusion)
    
    TP   <-  TP + confu[labels[2], labels[2]] 
    FN   <-  FN + confu[labels[2], labels[1]]
    FP   <-  FP + confu[labels[1], labels[2]]
    TN   <-  TN + confu[labels[1], labels[1]]
    
  }
  
    TPR <- TP/(TP+FN)
    TNR <- TN/(TN+FP)
    BACC <- (TPR + TNR)/2
    print(BACC)
    fullfact.results <- c(fullfact.results, BACC)
  
}
Sys.time()

fullfac.design <- add.response(Design, fullfact.results)
print(summary(fullfac.design))



cat("\n print(summary(fullfac.design))\n");
print( summary(fullfac.design) );


write.csv(
x         = fullfac.design,
file      = "fullfac-design.csv",
row.names = FALSE)

#save(design.resp, file = "RFDOE.RData")

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    png(paste0("plot-","main-effects-full-factorial",".png"),height = 12, width = 12, units = "in", res = 3);
    MEPlot(obj   = frfc.results,
        # abbrev   = 5,
        # cex.xax  = 1.6,
        # cex.main = 2,
        main    = "Main effects plot for full factorial design");

     dev.off();

     png(paste0("plot-","interactions-full-factorial",".png"),height = 12, width = 12, units = "in", res = 3);
     IAPlot(obj = frfc.results,
         #abbrev = 5,
         show.alias = TRUE,
         # lwd = 2,
         # cex = 2,
         # cex.xax = 1.2,
         # cex.lab = 1.5,
         main = "Interactions plot for full Factorial Design");

     dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( frfc.results );

    }
