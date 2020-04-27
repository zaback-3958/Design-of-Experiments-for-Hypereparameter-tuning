
lm.fullfac.design <- function(
	DF.input   = NULL
	) {

	this.function.name <- "lm.fullfac.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(DoE.base);

	##################################################
	frfactorial.model <- lm(DF.input)

	cat("\ print(summary(frfactorial.model) )\n");
	print( print(summary(frfactorial.model) )   );
	
	pr    <- resid(frfactorial.model)/(1 - lm.influence(frfactorial.model)$hat)
	PRESS <- sum(pr^2)

	cat("\ print(PRESS )\n");
	print( print(PRESS )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( frfactorial.model);

	}





