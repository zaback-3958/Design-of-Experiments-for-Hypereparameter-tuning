foldover.design <- function(
    DF.Design           = NULL,
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
    
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\n### Fractional Design: ",resolution,"\n"));
    
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\n print(summary(DF.Design) )\n");
    print( summary(DF.Design)  );

    cat("\n print(design.info(DF.Design) )\n");
    print( design.info(DF.Design) );

    foldDesign <- fold.design(DF.Design)

    cat("\n print(foldDesign )\n");
    print( foldDesign  );

    cat("\n print(summary(foldDesign) )\n");
    print( summary(foldDesign)  );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    return(DF.Design = foldDesign  )
        }
