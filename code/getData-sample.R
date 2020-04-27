
test.RF <- function(
    DF.training   = NULL,
    DF.test = NULL
    ) {

    this.function.name <- "test.RF";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(randomForest);
    require(tidyr);
    require(stringr);


    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    # temp.matrix <- model.matrix(
    #     object = ~ -1 + x1 + x2 + x3,
    #     data   = DF.training
    #     );

    # DF.temp.training <- cbind(
    #     DF.training[,setdiff(colnames(DF.training),c("z1","z2","z3"))],
    #     temp.matrix
    #     );

    # cat("\nstr(DF.temp.training)\n");
    # print( str(DF.temp.training)   );

    #DF.temp[,"median_house_value"] <- DF.input[,"median_house_value"];
     

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    retained.predictors <- setdiff(colnames(DF.training),"median_house_value");
  
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
   trained.machine <- randomForest(
    x         = DF.training[,retained.predictors],
    y         = DF.training[,"median_house_value"],
    xtest     = DF.test[,retained.predictors],
    ytest     = DF.test[,"median_house_value"]
    );
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

    # trained.machine <- function(ntrees,mtrys,replace,nodesize,classwt,cutoff,maxnodes){
    
    # DoE.rf <- randomForest(
    #     x        = DF.training[,retained.predictors],
    #     y        = DF.training[,"median_house_value"],
    #     xtest    = DF.test[,retained.predictors],
    #     ytest    = DF.test[,"median_house_value"],
    #     ntree    = ntrees,
    #     mtry     = mtrys,
    #     replace  = replace,
    #     nodesize = nodesize,
    #     classwt  = classwt,
    #     cutoff   = cutoff,
    #     maxnodes = maxnodes)

    # performance.metric <- DoE.rf$test$mse

    # return(performance.metric)
    # }
    
    # cat("\nstr(trained.machine):\n");
    # print( str(trained.machine)    );

    # cat("\nstr(summary(trained.machine)):\n");
    # print( summary(trained.machine)    );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    # predictions.training <- predict(
    #     object  = trained.machine,
    #     newdata = DF.temp.training[,retained.predictors]
    #     );

    # cat("\nstr(predictions.training):\n");
    # print( str(predictions.training)    );


    # cat("\nstr(predictions.training.mse):\n");
    # print(mean(trained.machine$mse))

    # print(trained.machine$predictions.training$mse)

    # predictions.test <- predict(
    #     object  = trained.machine,
    #     newdata = DF.temp.test[,retained.predictors]
    #     );

    # predictions.test <- predict(
    #     object  = trained.machine,
    #     newdata = DF.test[,retained.predictors]
    #     );

    # cat("\nstr(predictions.test):\n");
    # print( str(predictions.test)    );

    # cat("\nstr(predictions.test.mse):\n");
    # print(trained.machine$predictions.test$mse)
    # print(mean(trained.machine$test$mse))

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    tuning.results <- data.frame();
    for ( ntree        in c(100,500) ) {
        for ( mtry         in c(3,4) ) {
            for(nodesize in c(5,nrow(DF.training))) {
                #for (maxnodes in c(1, NULL)){
                    for (replace in c(TRUE, FALSE)){
        
    #temp.list <- list();
    count <- 0;

    # count  <- count + 1;
    # print(count)
    # mdata.suffix <- stringr::str_pad(string = count, width = 3, pad = "0");
    # mdata.ID     <- paste0("result_RF_",mdata.suffix);
    
    get.RF <- randomForest(
        x        = DF.training[,retained.predictors],
        y        = DF.training[,"median_house_value"],
        xtest    = DF.test[,retained.predictors],
        ytest    = DF.test[,"median_house_value"],
        ntree    = ntree,
        mtry     = mtry,
        nodesize = nodesize,
        #maxnodes = maxnodes,
        replace  = replace
        )

    train.mse <- mean(get.RF$mse)
    #test.mse  <- mean(get.RF$test$mse)

    #hyperparameters.combo <- as.data.frame(cbind(ntree,mtry,nodesize,maxnodes,replace,train.mse,test.mse))
    hyperparameters.combo <- as.data.frame(cbind(ntree,mtry,nodesize,replace,train.mse))
    tuning.results        <- as.data.frame(rbind(tuning.results,hyperparameters.combo))
        
}}}}#}

cat("\nstr(tuning.results):\n");
print(tuning.results)

write.csv (
     file      = paste0("tuning-results.csv"),
     x         = tuning.results,
     row.names = FALSE
    )

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    tuning.results.rnd <- data.frame();
    for ( ntree        in sample(c(100,500),1) ) {
        for ( mtry         in sample(c(3,4) ,1)) {
            for(nodesize in sample(c(5,nrow(DF.training)),1)) {
                #for (maxnodes in c(1, NULL)){
                    for (replace in sample(c(TRUE, FALSE),1)){
        
    #temp.list <- list();
    count <- 0;

    # count  <- count + 1;
    # print(count)
    # mdata.suffix <- stringr::str_pad(string = count, width = 3, pad = "0");
    # mdata.ID     <- paste0("result_RF_",mdata.suffix);
    
    get.RF <- randomForest(
        x        = DF.training[,retained.predictors],
        y        = DF.training[,"median_house_value"],
        xtest    = DF.test[,retained.predictors],
        ytest    = DF.test[,"median_house_value"],
        ntree    = ntree,
        mtry     = mtry,
        nodesize = nodesize,
        #maxnodes = maxnodes,
        replace  = replace
        )

    train.mse <- mean(get.RF$mse)
    #test.mse  <- mean(get.RF$test$mse)

    #hyperparameters.combo <- as.data.frame(cbind(ntree,mtry,nodesize,maxnodes,replace,train.mse,test.mse))
    hyperparameters.combo <- as.data.frame(cbind(ntree,mtry,nodesize,replace,train.mse))
    tuning.results.rnd        <- as.data.frame(rbind(tuning.results.rnd,hyperparameters.combo))
        
}}}}#}

cat("\nstr(tuning.results.rnd):\n");
print(tuning.results.rnd)

write.csv (
     file      = paste0("tuning.results.rnd.csv"),
     x         = tuning.results.rnd,
     row.names = FALSE
    )

	
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###

train.default.mse <- mean(get.RF$mse)
test.default.mse  <- mean(get.RF$test$mse)

cat("\nstr(train.default.mse):\n");
print(train.default.mse)

cat("\nstr(test.default.mse):\n");
print(test.default.mse)


cat("\nstr(summary.train.machine):\n");
print(summary(trained.machine))

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
train.default.mse <- mean(get.RF$mse)
test.default.mse  <- mean(get.RF$test$mse)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ s###
    # png(paste0("plot-",model.name,"-predictions-training.png"), height = 12, width = 12, units = "in", res = 300);
    # plot(
    #     x    = DF.training[,"y"],
    #     y    = predictions.training,
    #     xlim = c(-20,100),
    #     ylim = c(-20,100),
    #     type = "p",
    #     cex  = 0.5,
    #     col  = "black"
    #     );
    # dev.off();

    # png(paste0("plot-",model.name,"-predictions-test.png"), height = 12, width = 12, units = "in", res = 300);
    # plot(
    #    x    = DF.test[,"y"],
    #    y    = predictions.test,
    #    xlim = c(-20,100),
    #    ylim = c(-20,100),
    #    type = "p",
    #    cex  = 0.5,
    #    col  = "black"
    #    );
    # dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( NULL );

    }
