
get.DoE.factors <- function(
	input.data   = NULL,
	hyperparameters.csv = "list.hyperparameters.csv"
	) {

	this.function.name <- "get.DoE.factors";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);
    require(rsm);

	##################################################
	data.to.DoE <- read.csv(file = input.data , stringsAsFactors = FALSE);


	cat("\nstr(data.to.DoE )\n");
	print( str(data.to.DoE )   );

	#rsm.results <- rsm(y ~ SO(a, b, c), data = df.3.1.long)

	#rsm.results <- rsm(y ~ SO(x1, x2), data = data.to.DoE)

	rsm.results <- rsm(train.mse ~ SO(ntree,mtry,nodesize,replace), data = data.to.DoE);

	cat("\nstr(summary(rsm.results) )\n");
	print( summary(rsm.results ) );
	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	factorialdesign.results <- FrF2::FrF2 (16,4,factor.names = c("ntree","mtry","nodesize","replace"),randomize = FALSE)

	cat("\nstr(factoraldesign.results):\n");
	print(factoraldesign.results)
	 ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	fractionaldesign.results <- FrF2::FrF2 (4,4,res3 = TRUE,factor.names = c("ntree","mtry","nodesize","replace"),randomize = FALSE)

	cat("\nstr(fractionaldesign.results):\n");
	print(fractionaldesign.results)

	 ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	
	cat("\nstr(aliasprint factoraldesign):\n");
	aliasprint(factoraldesign.results)


	aliasprint(fractionaldesign.results)
	cat("\nstr(aliasprint factoraldesign):\n");

	#print(summary(rsm.results));
	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( NULL );

	}





