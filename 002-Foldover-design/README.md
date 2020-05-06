# Foldover Design
The Design <img src="http://latex.codecogs.com/gif.latex?&space;2_{IV}^{7-2}" border="0"/> made some of the main factors to be alised with higher order interactions and the two-factor interations to be alised with each other. As it was discussed in section ``001-fractional-factorial-design-IV`` if some of the factors are alised, they can be dealised by foldover design. The number of runs for foldover design is twice the original design. In this design the levels of all the factors are reversed and added to the design. Although, it has to be noted that the foldover design <img src="http://latex.codecogs.com/gif.latex?&space;IV" border="0"/> does not necessrily removes all the alises. The design was performed and the result were displayed in output section. 
# Requirements
* R v3.6.2
* packages: FrF2, RandomForest
# How to execute the pipeline
Clone this repository by running the following at the command line:

git clone ``https://github.com/zaback-3958/ML-DoE.git`` 

Change directory to the folder of this pipeline in the local cloned repository:

``cd <LOCAL CLONED REPOSITORY>/ML-DoE/003-foldover-design``

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
The foldover design was performed from package FrF2 in R and the output file and graphas can be seen in ``<LOCAL CLONED REPOSITORY>/ML-DoE/003-fractional-factorial-design/output/2020-05-04-01``. The output includes the main effect graphs for train and validation data, the interaction effect graphs of train and validation data, the error log file and the outpput file. As it can be seen in the output file ``stdout.R.runall``the main factors are not alised, although, the interactions effects that were alised for design <img src="http://latex.codecogs.com/gif.latex?&space;2_{IV}^{7-2}" border="0"/> remained alised. The interaction effects of ``cutoff`` was aliased with some other interactions. 

![Test Image 1](https://github.com/zaback-3958/ML-DoE/blob/master/003-foldover-design/output/2020-05-04-01/plot-main-effects-fractional-factorial-train-IV.png)

This graph shows that the main effects maxnodes, nodesize, and classwt are very significant. The effect of mtry is also significant but it is not as strong as those three factors by looking at the estimated effects. 


![Test Image 2](https://github.com/zaback-3958/ML-DoE/blob/master/003-foldover-design/output/2020-05-04-01/plot-main-effects-fractional-factorial-valid-IV.png)

This graph also shows that the main effects maxnodes, nodesize, and classwt are very significant, and the effect of mtry is not siginificant for validation data.


![Test Image 3](https://github.com/zaback-3958/ML-DoE/blob/master/003-foldover-design/output/2020-05-04-01/plot-interactions-fractional-factorial-train-IV.png)

As it can be observed from the graph the interactions between the following factors are significant: nodesize:cutoff, nodesize:maxnodes, classwt:cutoff,cutoff:maxnodes.

![Test Image 4](https://github.com/zaback-3958/ML-DoE/blob/master/003-foldover-design/output/2020-05-04-01/plot-interactions-fractional-factorial-valid-IV.png)

This graph shows that the interactions between the following factors are significant:
nodesize:cutoff, nodesize:maxnodes, classwt:cutoff, cutoff:maxnodes   

As it was observed in the graphs for both train and validation data the main effect ``cutoff`` is not significant, but its interaction with other factors is significant. 

The comparison between the results of foldover design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VI}^{7-2}" border="0"/> and design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> for train data shows that the similar main effects are significant in both design, however the interaction ``replace:classwt`` which is present for the foldover design is missing for design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/>. Furthermore, for validation data, the main effect ``replace``  and its interactions with other factors is only significant for foldover design. The main effect cutoff is not siginificant in neither designs, but its interactions with other factors is significant. Since in the foldover design some of the two-factor interactions are still alised with each other, the significant interactions cannot be extracted. Therefore, the results of design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> with no alised factors provides better information about the siginificant main factor effects and interactions. 
