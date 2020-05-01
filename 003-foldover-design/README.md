# Foldover Design
As it was discussed in the first section 001-fractional-factorial-design if some of the factors are alised, they can be dealised by foldover design. The first Design <img src="https://latex.codecogs.com/svg.latex?2_{IV}^{7-2}"/> made the main factors to be alised with higher order interactions and the two-factor interations to be alised with each other. Since in this design the interaction of factor cutoff with some other factors was significant, but its main effect did show significancy, it is required to isolate the two-factor effects to identify the interactions that have significant effect on the response. The number of runs for foldover design is twice the original design. In this design the levels of all the factors are reversed and added to the dsign.

# Requirements
* R v3.6.2
* packages: FrF2, DoE.base, RandomForest, RSM
# How to execute the pipeline
Clone this repository by running the following at the command line:

git clone ``https://github.com/zaback-3958/ML-DoE.git`` 

Change directory to the folder of this pipeline in the local cloned repository:

``cd <LOCAL CLONED REPOSITORY>/ML-DoE/``

If you are using a Windows computer, execute the following batch script at the Command Prompt instead:

``.\run-main.bat``

If you are using a Linux or macOS computer, execute the following shell script in order to run the full pipeline((NOT tested)):

``.\run-main.sh``

This will trigger the creation of the output folder <LOCAL CLONED REPOSITORY>/ML-DoE/output/ if it does not already exist, followed by execution of the pipeline. All output and log files will be saved to the output folder. See below for information about the contents of the output folder.
  
# Input file

The required input data files in cluded adult dataset and Boston housing dataset are located in ``<LOCAL CLONED REPOSITORY>/data/``.

* adult.csv
* housing.csv

These datasets were obtained from UCI ML repository:

``https://archive.ics.uci.edu/ml/datasets/adult``

``https://archive.ics.uci.edu/ml/machine-learning-databases/housing/``

The adult dataset is used for classification to predict whether income exceeds $50K a year according to the census data. The housing dataset is used for regression to predict the median housing price. 


# Main output files
This is the first phase of this project for which the results of Fractional Factorial Design were obtained. In this phase the effect of seven hyper-parameters of Random Forest was evaluated on the perfomrmance of the model (i.e. BACC for adult dataset as classification problem). As it was mentioned above the Fractional Factorial Design of ![eq24](https://latex.codecogs.com/gif.latex?2_%7BIV%7D%5E%7B7-2%7D) was selected. In this design the main effects are not alised with two-factor interactions, However the main effects are alised with three-factor interactions and two-factor interactions are alised with each other. It is required to see the results and decide if some of the main effects or interactions need to be de-alised.  

The experiments was done by dividing the dataset into train,valiadtio, and test and also a 10-fold cross validation was performed. The main effects graph in the output folder ``<LOCAL CLONED REPOSITORY>/ML-DoE/output/`` shows that the hyper-parameters ``nodesize, maxnode, replace, classwt`` have significant effect on the response which is according to the result was obtained in ``stdout.R.runall``. Also, the interaction effects shows that the interactions ``replace:nodesize, replace:classwt, replace:maxnodes, nodesize:cutoff, nodesize:maxnodes, classwt:cutoff, cutoff:maxnodes`` have significant effects on the reponse. It can be observed that the main effect of cutoff is not significant, but some of its interactions with others is significant. Since in this design the main effects are alised with higher order effects and two-factor interactions are alised with other two-factor interactions, it is required to de-alise the factor effects to find the real main effects and interactions that have significant effect on the resoinse. In the next phase the foldover design needs to be used to extract the significant main effects and interactions.
