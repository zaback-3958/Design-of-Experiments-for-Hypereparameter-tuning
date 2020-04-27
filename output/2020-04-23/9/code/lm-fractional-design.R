
lm.fractional.design <- function(
	DF.input   = NULL
	) {

	this.function.name <- "lm.fractional.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);

	##################################################
	
	frfc.model.test <- lm(DF.input)

	cat("\ print(summary(frfc.model.test) )\n");
	print( print(summary(frfc.model.test) )   );
	
	press.result.test <- press.func(DF.input = frfc.model.test)

	cat("\ print(press.result.testt )\n");
	print( print(press.result.test )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( NULL);

	}

##################################################
	press.func <- function(
		DF.input = NULL) {
			pred <- residuals(DF.input)/(1-lm.influence(DF.input)$hat)
			press <- sum(pred^2)
		return(press)
	}



