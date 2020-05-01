# Fractional Factorial Design II
This is another experiment to use Fractional Factorial Design to have fewer main effects and two-factor interaction effect to be aliased. From the first phase it was observed that the main effect cutoff was not significant, but its interaction with some other factors was significant. In this phase another design was used to be able to isolate the effect of this main factor and hopefully its interaction with other factors. The Design <img src="http://latex.codecogs.com/gif.latex?2_{VII}^{7-1}" border="0"/> was selected . 

<img src="http://latex.codecogs.com/gif.latex?2_{IV}^{7-2}" border="0"/>


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
This is the second phase of this project for which the results of Fractional Factorial Design were obtained. In this design the main effects are not alised with two-factor interactions, However the main effects are alised with three-factor interactions and two-factor interactions are alised with each other. It is required to see the results and decide if some of the main effects or interactions need to be de-alised.  
