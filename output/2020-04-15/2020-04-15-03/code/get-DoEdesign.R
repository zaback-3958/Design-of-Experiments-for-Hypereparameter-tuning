
get.DoE.design <- function(
	nFactors   = NULL,
	kFactors    = NULL
	) {

	this.function.name <- "get.DoE.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);
    require(rsm);

	##################################################
design <- FrF2(
(nfactors      = 2^(nFactors-kFactors)),
 nFactors      = nFactors,
 factor.names  = list(
	 ntree     = c(-1,1),
	 mtry      = c(-1,1),
	 replace   = c(-1,1),
	 nodesize  = c(-1,1),
	 classwt   = c(-1,1),
	 cutoff    = c(-1,1),
	 maxnodes  = c(-1,1) ),
	   seed    = 6285)

	cat("\ print(DoE.design )\n");
	print( print(design )   );
	
	cat("\ summary(design )\n");
	print( summary(design )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( design);

	}





