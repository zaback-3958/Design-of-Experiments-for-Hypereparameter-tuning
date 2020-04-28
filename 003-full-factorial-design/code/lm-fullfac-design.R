
lm.fullfac.design <- function(
	DF.fullfc.train   = NULL,
	DF.fullfc.valid   = NULL,
	DF.fullfc.test    = NULL
	) {

	this.function.name <- "lm.fullfac.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(DoE.base);

	##################################################
	fullfc.model.train <- lm(DF.fullfc.train)

	cat("\ print(summary(fullfc.model.train) )\n");
	print( print(summary(fullfc.model.train) )   );
	
	press.result.train <- press.func(DF.input = fullfc.model.train)

	cat("\ print(press.result.train )\n");
	print( print(press.result.train )   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	fullfc.model.valid <- lm(DF.fullfc.valid)

	cat("\ print(summary(fullfc.model.valid) )\n");
	print( print(summary(fullfc.model.valid) )   );
	
	press.result.valid <- press.func(DF.input = fullfc.model.valid)

	cat("\ print(press.result.valid )\n");
	print( print(press.result.valid )   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	fullfc.model.test <- lm(DF.fullfc.test)

	cat("\ print(summary(fullfc.model.test) )\n");
	print( print(summary(fullfc.model.test) )   );
	
	press.result.test <- press.func(DF.input = fullfc.model.test)

	cat("\ print(press.result.test )\n");
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






