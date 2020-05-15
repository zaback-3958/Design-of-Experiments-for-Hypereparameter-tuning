
bbdes.design <- function(
	k   = NULL
	) {

	this.function.name <- "bbdes.design";
	cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
	cat(paste0("starting: ",this.function.name,"()\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);
    require(FrF2);
    require(rsm);

	##################################################
	cat(paste0(" \n Box-Behnken:","k=",k ,"\n"))

	
	bbdes.design <- bbd(k = k, n0 = 3)


	# bbdes.design <- bbd(k = k, n0 = 3, coding =
 #                list(x1 ~ (nodesize - 6)/3,
 #                     x2 ~ (classwt - 10)/2, x3 ~ (cutoff - 0.8)/0.05))


	cat("\ print(bbdes.design )\n");
	print( print(bbdes.design )   );
	
	cat("\ summary(bbdes.design )\n");
	print( summary(bbdes.design )   );

	### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
	cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));

    return( bbdes.design);

	}





