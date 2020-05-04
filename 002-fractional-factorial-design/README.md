# Fractional Factorial Design (Resolution VII)
This is the second experiment to use Fractional Factorial Design to have fewer main effects and two-factor interaction effect to be aliased. From the first phase it was observed that the main effect cutoff was not significant, but its interaction with some other factors was significant. In this phase another design was used to be able to isolate the effect of this main factor and hopefully its interaction with other factors. The Design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> was selected . 

# Requirements
* R v3.6.2
* packages: FrF2, DoE.base, RandomForest, RSM
# How to execute the pipeline
Clone this repository by running the following at the command line:

git clone ``https://github.com/zaback-3958/ML-DoE.git`` 

Change directory to the folder of this pipeline in the local cloned repository:

``cd <LOCAL CLONED REPOSITORY>/ML-DoE/002-fractional-factorial-design``

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
The result of Fractional Factorial Design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> was obtained and the output file and graphas can be seen in ``<LOCAL CLONED REPOSITORY>/output/2020-05-01``.

As it can be in the 

