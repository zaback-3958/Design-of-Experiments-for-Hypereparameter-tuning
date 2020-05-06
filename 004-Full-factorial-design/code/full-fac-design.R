
full.fac.design <- function(
	nFactors    = NULL
	) {

	this.function.name <- "full.fac.designn";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(DoE.base);
    require(FrF2);

	##################################################
	cat(paste0(" \n Full Factorial Design:","n=",nFactors ,"\n"))

	design <- fac.design(
		nfactors         = nFactors,
		factor.names     = list(
			nodesize     = c(-1,1),
			classwt      = c(-1,1),
			cutoff       = c(-1,1),
			maxnodes     = c(-1,1) ),
			replications = 2,
			seed         = 6285)

	cat("\ print(full.factorial.design )\n");
	print( print(design )   );
	
	cat("\ summary(full.factorial.design )\n");
	print( summary(design ) );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( design);

	}





