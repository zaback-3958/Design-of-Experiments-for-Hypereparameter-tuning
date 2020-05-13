# Response Surface Methods 

Response Surface methodology (**RSM**) is a series of statistical and mathematica technique that are useful to optimize a reponse variable that is influenced by some variables. For instance an experimenter would be interested in finding the levels of variables <img src="http://latex.codecogs.com/gif.latex?&space;x_{1}" border="0"/>   and  <img src="http://latex.codecogs.com/gif.latex?&space;x_{2}" border="0"/> that maximize or minimize the response <img src="http://latex.codecogs.com/gif.latex?&space;y" border="0"/>. The response is a function of levels of these two variables as below:

<img src="http://latex.codecogs.com/gif.latex?&space;y=&space;f(x_{1},x_{2})&space;+\epsilon" border="0"/>

Where <img src="http://latex.codecogs.com/gif.latex?&space;\epsilon" border="0"/> represents the error of the model. The expected value of the response is :

<img src="http://latex.codecogs.com/gif.latex?&space;E(y)=&space;f(x_{1},x_{2})=&space;\eta" border="0"/>

As a result the surface is represented by:

<img src="http://latex.codecogs.com/gif.latex?&space;\eta=&space;f(x_{1},x_{2})" border="0"/>

And it is called **response surface**. 

Since in most RSM methods the relationship between responce and the independent variables is not known, a proper approximation of the relationship between them must be found. In general, at first a low order poly-nomial model is applied in some regions of the independent variables and if the statistical analysis shows that it this model is not appropriate a higher order model will be applied. The first-order model can be written as below:

<img src="http://latex.codecogs.com/gif.latex?&space;y=&space;\beta_{0}+\beta_{1}x_{1}+\beta_{2}x_{2}+\cdots+\beta_{k}x_{k}+\epsilon" border="0"/>
if a highr order model is identified the second-order model will be applied as below:

<img src="http://latex.codecogs.com/gif.latex?&space;y=&space;\beta_{0}+\sum_{i=1}^{k}\beta_{i}x_{i}+\sum_{i=1}^{k}\beta_{ii}x_{i}^{2}+\sum_{i<j}\sum\beta_{ij}x_{i}x_{j}+\epsilon" border="0"/>

This poly-nomial model does not represent the functional relationship between response and the variables over the entire space, but it could be a proper approximation for a very small region of the function. The experimental designs are performed to collect the data and the RSM parameters can be estimated. These designs are called RSM designs. There are different methods to find the optimum for response depending on the type of model. For the first-order model, method of steepest ascend/descend is performed to maximize/minimize the function. For the second order model the ridge analysis is performed.

## First-Order Model (Steepest Ascend/Descend Method)

Most of the time the initial values for the variables to optimize the response is far from optimum. In this situation the experimenter desires to move very rapidly to the closest neighborhood of the optimum. At the begining, it is assumed that the first order model can provide a good approximation in a small region of the independent variables. The method of steepest ascend/descend is a sequential procedure which provides a path in the direction of the maximum increase/decsease in the response step by step. The steepest ascend/descend direction is parallel to the normal to the fitted response and its steps are proportional to the model parameters <img src="http://latex.codecogs.com/gif.latex?&space;\beta_{i}" border="0"/>. The experimenter decides on the steps according to the experience or other consideration. The optimization of the model continues untill no further increase/decsrease in the response is observed. Then, a new first-order model might be applied with new steepest ascend/descend method. At the end, by repeating this process, it can be get closer to the optimum. At this point lack of fit test shows if the first-order model is adequate or a second-order model should be applied.

## Second-Order Model (Ridge Analysis) 
When the first-order model is not adequate and the experimenter is in the vicinity of the optimum, most of the time a second order model would be appropriate to find the set of values for independent variables that optimizes the response. In fact, the experimenter is looking for levels of the independent variables that partail derivatives of the second-order function at those levels are zero. That point is called a stationary point which could represent a Maximum, Minimum, or saddle point. The second-order model can be written in matrix notation as below:

<img src="http://latex.codecogs.com/gif.latex?&space;\hat{y}=&space;\hat{\beta}_{0}+\acute{\bold{x}}b+\acute{\bold{x}}B\bold{x}" border="0"/>

where:

<img src="http://latex.codecogs.com/gif.latex?\begin{bmatrix}x_{1}\\x_{2}\\&space;\vdots\\x_{k}\end{bmatrix}&space;&space;&space;&space;&space;\;\;\;\begin{bmatrix}\beta_{1}\\\beta_{2}\\&space;\vdots\\&space;\beta_{k\end{bmatrix}\;\;\;\;\begin{bmatrix}\hat{\beta_{11}} & \hat{\beta_{12}}/2 &\cdots & \hat{\beta_{1k}}/2 & \\ & \hat{\beta_{22}}/2 &\cdots &\hat{\beta_{2k}}/2 & \\ & &\ddots\\sym.&  &  & \hat{\beta_{kk}}\end{bmatrix}" border="0"/>



# Requirements
* R v3.6.2
* packages: FrF2, RandomForest
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
  
  hi
  
# Input file

The required input data files in cluded adult dataset and Boston housing dataset are located in ``<LOCAL CLONED REPOSITORY>/data/``.

* adult.csv
* housing.csv

These datasets were obtained from UCI ML repository:

``https://archive.ics.uci.edu/ml/datasets/adult``

``https://archive.ics.uci.edu/ml/machine-learning-databases/housing/``

The adult dataset is used for classification to predict whether income exceeds $50K a year according to the census data. The housing dataset is used for regression to predict the median housing price. 


# Main output files
The Fractional Factorial Design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> was performed using FrF2 package in R and the output file and graphas can be seen in ``<LOCAL CLONED REPOSITORY>/ML-DoE/002-fractional-factorial-design/output/2020-05-01``. The output includes the main effect graphs for train and test data, the interaction effect graphs of train and test data, the error log file and the outpput file. As it can be seen in the output file ``stdout.R.runall``the main factors and interactions are not alised. 

![Test Image 1](https://github.com/zaback-3958/ML-DoE/blob/master/003-Fractional-factorial-design-VII/output/2020-05-09/plot-main-effects-fractional-factorial-train-VII.png)

This graph shows that the main effects maxnodes, nodesize, and classwt are very significant. The effect of mtry is also significant but it is not as strong as those three factors by looking at the estimated effects. 


![Test Image 2](https://github.com/zaback-3958/ML-DoE/blob/master/003-Fractional-factorial-design-VII/output/2020-05-09/plot-main-effects-fractional-factorial-test-VII.png)

This graph also shows that the main effects maxnodes, nodesize, and classwt are very significant, and the effect of mtry is not siginificant for test data.


![Test Image 3](https://github.com/zaback-3958/ML-DoE/blob/master/003-Fractional-factorial-design-VII/output/2020-05-09/plot-interactions-fractional-factorial-train-VII.png)

As it can be observed from the graph the interactions between the following factors are significant: nodesize:cutoff, nodesize:maxnodes, classwt:cutoff,cutoff:maxnodes.

![Test Image 4](https://github.com/zaback-3958/ML-DoE/blob/master/003-Fractional-factorial-design-VII/output/2020-05-09/plot-interactions-fractional-factorial-test-VII.png)

This graph shows that the interactions between the following factors are significant:
nodesize:cutoff, nodesize:maxnodes, classwt:cutoff, cutoff:maxnodes   

As it was observed in the graphs for both train and test data the main effect cutoff is not significant, but its interaction with other factors is significant. 

The comparison between the results of design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VI}^{7-2}" border="0"/> and design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> shows that the main effect ``replace`` and its interactions  which was siginificant for the test data in the first design was not signinficant for the second design. The main effect ``cutoff`` is not siginificant in neither designs, but its interactions with other factors is significant. the main effect factor ``mtry`` was significant in both design for train data. 

The comparison between the results of design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> and foldover design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VI}^{7-2}" border="0"/> for train data shows that the similar main effects are significant in both design, however the interaction ``replace:classwt`` which is present for the foldover design is missing for design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/>. Furthermore, for test data, the main effect ``replace``  and its interactions with other factors is only significant for foldover design. The main effect ``cutoff`` is not siginificant in neither designs, but its interactions with other factors is significant. Since in the foldover design some of the two-factor interactions are still alised with each other, the significant interactions cannot be extracted. Therefore, the results of design <img src="http://latex.codecogs.com/gif.latex?&space;2_{VII}^{7-1}" border="0"/> with no alised factors provides better information about the siginificant main factor effects and interactions. 


