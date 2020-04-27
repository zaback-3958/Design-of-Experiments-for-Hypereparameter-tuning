
lm.fractional.design <- function(
	DF.frc.train   = NULL,
	DF.frc.valid   = NULL,
	DF.frc.test    = NULL
	) {

	this.function.name <- "lm.fractional.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);

	##################################################
	frfc.model.train <- lm(DF.frc.train)

	cat("\ print(summary(frfc.model.train) )\n");
	print( print(summary(frfc.model.train) )   );
	
	press.result.train <- PRESS.func(DF.input = frfc.model.train)

	cat("\ print(press.result.train )\n");
	print( print(press.result.train )   );


### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	frfc.model.valid <- lm(DF.frc.valid)

	cat("\ print(summary(frfc.model.valid) )\n");
	print( print(summary(frfc.model.valid) )   );
	
	press.result.valid <- PRESS.func(DF.input = frfc.model.valid)

	cat("\ print(press.result.valid )\n");
	print( print(press.result.valid )   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	frfc.model.test <- lm(DF.frc.test)

	cat("\ print(summary(frfc.model.test) )\n");
	print( print(summary(frfc.model.test) )   );
	
	press.result.test <- PRESS.func(DF.input = frfc.model.test)

	cat("\ print(press.result.testt )\n");
	print( print(press.result.test )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( NULL);

	}
	##################################################
	PRESS.func <- function(
		DF.input = NULL) {
			pred <- residuals(DF.input)/(1-lm.influence(DF.input)$hat)
			PRESS <- sum(pred^2)
		return(PRESS)
	}



