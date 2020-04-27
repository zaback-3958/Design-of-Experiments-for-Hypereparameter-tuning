
cross.validation <- function(
DF.input = NULL) {


	this.function.name <- "cross.validation";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    require(caret);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    #cross-validation
    createIndex <- rep(1:10, length.out = nrow(DF.input))
    randomIndex <- sample(createIndex)

    cat("\n str(createIndex )\n");
	print( str(createIndex )   );
    
    cat("\n str(randomIndex )\n");
	print( str(randomIndex )   ); 

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    
    return( randomIndex );

    }
