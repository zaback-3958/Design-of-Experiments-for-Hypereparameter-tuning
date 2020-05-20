
rsm.models.design <- function(
	DF.RFbbd.train   = NULL,
	DF.RFbbd.valid   = NULL
	#DF.RFbbd.valid   = NULL
	) {

	this.function.name <- "rsm.models.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    # cat("\n print(DF.RFbbd.train))\n");
    # print( DF.RFbbd.train );
    require(dplyr);
    require(FrF2);
    require(rsm)

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	RF.rsm.FO.train <- rsm(response_train ~ FO(x1, x2, x3), data = DF.RFbbd.train)

	cat("\ print(summary(RF.rsm.FO.train) )\n");
	print( print(summary(RF.rsm.FO.train) )   );

	RF.rsm.FO.valid <- rsm(response_valid ~ FO(x1, x2, x3), data = DF.RFbbd.valid)

	cat("\ print(summary(RF.rsm.FO.valid) )\n");
	print( print(summary(RF.rsm.FO.valid) )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

	RF.rsm.TWI.train <- update(RF.rsm.FO.train, .~. + TWI(x1, x2, x3))

	cat("\ print(summary(RF.rsm.TWI.train) )\n");
	print( print(summary(RF.rsm.TWI.train) )   );

	RF.rsm.TWI.valid <- update(RF.rsm.FO.valid, .~. + TWI(x1, x2, x3))

	cat("\ print(summary(RF.rsm.TWI.valid) )\n");
	print( print(summary(RF.rsm.TWI.valid) )   );


	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

	RF.rsm.PQ.train <- update(RF.rsm.FO.train, .~. +PQ(x1, x2, x3))

	cat("\ print(summary(RF.rsm.PQ.train) )\n");
	print( print(summary(RF.rsm.PQ.train) )   );

	RF.rsm.PQ.valid <- update(RF.rsm.FO.valid, .~. +PQ(x1, x2, x3))

	cat("\ print(summary(RF.rsm.PQ.valid) )\n");
	print( print(summary(RF.rsm.PQ.valid) )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	RF.rsm.SO.train <- rsm(response_train ~ SO(x1, x2, x3), data = DF.RFbbd.train)

	cat("\ print(summary(RF.rsm.SO.train) )\n");
	print( print(summary(RF.rsm.SO.train) )   );

	RF.rsm.SO.valid <- rsm(response_valid ~ SO(x1, x2, x3), data = DF.RFbbd.valid)

	cat("\ print(summary(RF.rsm.SO.valid) )\n");
	print( print(summary(RF.rsm.SO.valid) )   );
	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###


	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

	bbd.model.train <- lm(RF.rsm.SO.train)

	cat("\ print(summary(bbd.model.train) )\n");
	print( print(summary(bbd.model.train) )   );
	
	press.result.train <- press.func(DF.input = bbd.model.train)

	cat("\ print(press.result.train )\n");
	print( print(press.result.train )   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	bbd.model.valid <- lm(RF.rsm.SO.valid)

	cat("\ print(summary(bbd.model.valid) )\n");
	print( print(summary(bbd.model.valid) )   );
	
	press.result.valid <- press.func(DF.input = bbd.model.valid)

	cat("\ print(press.result.valid )\n");
	print( print(press.result.valid )   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	# bbd.model.valid <- lm(DF.RFbbd.valid)

	# cat("\ print(summary(bbd.model.valid) )\n");
	# print( print(summary(bbd.model.valid) )   );
	
	# press.result.valid <- press.func(DF.input = bbd.model.valid)

	# cat("\ print(press.result.valid )\n");
	# print( print(press.result.valid )   );

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



