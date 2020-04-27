
command.arguments <- commandArgs(trailingOnly = TRUE);
print(command.arguments)
dir.data <- normalizePath( command.arguments[1] );
dir.code <- normalizePath( command.arguments[1] );
dir.out  <- normalizePath( command.arguments[2] );

# add custom library using .libPaths()
cat("\ndir.data: ", dir.data );
cat("\ndir.code: ", dir.code );
cat("\ndir.out:  ", dir.out  );
cat("\n\n##### Sys.time(): ",format(Sys.time(),"%Y-%m-%d %T %Z"),"\n");

start.proc.time <- proc.time();
setwd( dir.out );

cat("\n##################################################\n");
require(dplyr);
require(FrF2);
require(rsm);
require(DoE.base);

code.files <- c(
	"getData-sample.R",
	#"get-DoEfactors.R",
	"splitTrainTest.R",
	"get-DoEdesign.R",
	"cross-validation.R",
	"bacc-measure.R",
	"RF-frcfac-results.R",
	#"RF-results.R",
	"lm-fractional-design.R",
	"test-RF.R",
	"visualize-effects.R"
	# "initializePlot.R",
	# "visualize-data.R"
	);

for ( code.file in code.files ) {
	source(file.path(dir.code,code.file));
	}

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
#data.snapshot <- "2019-11-05.01";

# housingFILE = file.path(dir.data,"housing.csv")
# DF.housing   = read.csv("housingFILE.csv");

# read.csv( file.path(folder.year,errors.csv) )

#DF.housing = read.csv(file.path(dir.data,"housing.csv"))
set.seed(7654321);

#DF.mytxt = read.table(file.path(dir.data,"rsm.txt"),header=TRUE, skip=1)

# cat("\nstr(DF.mytxt)\n");
# print( str(DF.mytxt)   );


### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
set.seed(1234567);

# load data
# DF.housing <- read.csv(
#     file   = file.path(dir.data,"housing.csv"),
#     header = TRUE
#     );
#DF.housing <- na.omit(DF.housing)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
set.seed(1234567);

DF.adult <- read.csv(
    file   = file.path(dir.data,"adult.csv"),
    header = TRUE
    );
DF.adult <- na.omit(DF.adult)

list_na <- colnames(DF.adult)[ apply(DF.adult, 2, anyNA) ]
median_missing <- apply(DF.adult[,colnames(DF.adult) %in% list_na],2,median,na.rm =  TRUE)


DF.adult[,ncol(DF.adult)] <- as.factor(DF.adult[,ncol(DF.adult)])
classes <- unique(DF.adult[,ncol(DF.adult)])

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
retained.predictors <- setdiff(colnames(DF.adult),"my_res");

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
#LIST.trainTest <- splitTrainTest(DF.input = DF.housing);

#cat("\nstr(LIST.trainTest)\n");
#print( str(LIST.trainTest)   );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
get.DoEDesign <- DoE.design(
kFactors = 7,
pFactors = 2)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
# get.crossvalidation <- cross.validation(
# DF.input = DF.adult)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
getRF.results <- RF.results(
DF.input             = DF.adult,
Design               = get.DoEDesign,
#randomIndex          = get.crossvalidation,
retained.predictors  = retained.predictors,
classes              = classes,
resolution           = "IV"
)
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
get.lmfrfc <- lm.fractional.design(
DF.input = getRF.results)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
# visualize.effect(
#        FILE.Factorial.design = "RFDOE.csv",
#        Design.name           = "fractional-factorial-IV"
#        );



cat("\n##################################################\n");
cat("\n##### warnings():\n");
print(       warnings()    );

cat("\n##### getOption('repos'):\n");
print(       getOption('repos')    );

cat("\n##### .libPaths():\n");
print(       .libPaths()    );

cat("\n##### sessionInfo():\n");
print(       sessionInfo()    );

# print system time to log
cat("\n##### Sys.time(): ",format(Sys.time(),"%Y-%m-%d %T %Z"),"\n");

# print elapsed time to log
stop.proc.time <- proc.time();
cat("\n##### stop.proc.time - start.proc.time:\n");
print(       stop.proc.time - start.proc.time    );
