
test.randomForest <- function(
    DF.input          = NULL,
    FILE.output.RData = "fittedModel-randomForest.RData"
    ) {

    this.function.name <- "test.randomForest";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(randomForest);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    #retained.predictors <- c('x1',x2));
    
    DF.temp <- DF.input[DF.input[,'Y'] > 0, retained.predictors];

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    if (file.exists(FILE.output.RData)) {

        cat(paste0("\nloading file: ",FILE.output.RData,"\n"));
        load(file = FILE.output.RData);

    } else {

        results.randomForest <- randomForest::randomForest(
            formula = Y ~ .,
            data    = DF.temp
            );
        
        cat(paste0("\nsaving to file: ",FILE.output.RData,"\n"));
        save(results.randomForest, file = FILE.output.RData);

        }

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\nstr(results.randomForest):\n");
    print( str(results.randomForest)    );

    predictions.randomForest <- predict(results.randomForest);
    cat("\nstr(predictions.randomForest):\n");
    print( str(predictions.randomForest)    );

    png("plot-predictions-randomForest.png", height = 12, width = 12, units = "in", res = 300);
    plot(
        x    = DF.temp[,"Y"],
        y    = predictions.randomForest,
        xlim = c(-20,100),
        ylim = c(-20,100),
        type = "p",
        cex  = 0.5,
        col  = "black"
        );
    dev.off();

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    mean.deviation <- mean(abs(predictions.randomForest - DF.temp[,"Yield"]) / DF.temp[,"Yield"]);
    cat("\nmean.deviation:\n");
    print( mean.deviation    );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return( NULL );

    }
