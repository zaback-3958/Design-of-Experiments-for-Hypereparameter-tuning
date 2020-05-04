# Design-of-Experiments-for-Hypereparameter-tuning
The goal of this project is to use Design of Expeiments (DoE) to do the hyperparameter tuning for some machine learning models based on an article by Gustavo et al. in:

https://asu.pure.elsevier.com/en/publications/design-of-experiments-and-response-surface-methodology-to-tune-ma

The authors used DoE to do the hyperparameter tunning for Random Forest. They used Fractional Factorial Design and full Factorial Design to find the hyper-parameters that have a significant effect on the performance of the model. Then they used Response Surface Method (RSM) to find the values for those hyper-parameters (the ones that were recognised in the previous steps) to optimize the performance of the model. They used BACC (Balanced accuracy which as they mentioned in the article can be used to measure the accuracy of an imbalanced dataset) to measure the performance of the model.

This work has been done according to the article to reproduce the results for Random Forest and then try to apply to some other machine learning models.

# Design of Experiments
An experiment is a test or series of tests in which some changes are made to the input to identify the effect of those changes on the reponse. Design of Experiment is a method in which the number of factors, their ranges of values and number of times to run the experiments are determined to identify the relationship between the factors and the response variable. One of the strategies of DoE to evaluate the effect of factors on the response is the method of **one factor at a time**. In this method the effect of each factor is evaluated on the response by holding the other factors constant. The disadvantage of this method is that it cannot recognize the interaction between factors. There is another strategy that considers several factors at the same time in which they are varied together and that is called **Factorial Design**. This type of design is very efficient and will be discussed later. There are three principles for DoE which include:
* Randomization : The allocation of the experimental unit and the order in which the trials are run needs to be randomized. By randomization the effect of the extraneous effect can be averaged out.
* Replication : It is the repetition of the basic experiment and helps to have a estimate of the experimental error. 
* Blocking : It is a technique to improve the precision when comparing the effect of factors and to reduce the effect of nuisance factors. 

There are several methods of DoE that can be used to do the experiments, and they are selected according to the problem and experimenter experience. In this project Factorial Design, Fractiional Factorial Design and Response Surface Method will be dicussed. 

## Single Factor Analysis (Analysis of Varaince) 
This a method of DoE that the effect of one factor with **a** levels (**a** treatments) on the response is evaluated. the model for this method is : 

<img src="http://latex.codecogs.com/gif.latex?Y_{ij}=\mu+\tau_{i}+\epsilon_{ij}" border="0"/>

 for <img src="http://latex.codecogs.com/gif.latex?i=1,2,\cdots,a" border="0"/> as number of factor levels (i.e. number of treatments),  <img src="http://latex.codecogs.com/gif.latex?j=1,2,\cdots,n" border="0"/> as number of replications where <img src="http://latex.codecogs.com/gif.latex?\mu" border="0"/>
 is the overal mean effec, and <img src="http://latex.codecogs.com/gif.latex?\tau_{i}" border="0"/>
is the effect of ``i-th``  level of factor ``A`` or the ``i-th`` treatment effect, and <img src="http://latex.codecogs.com/gif.latex?\epsilon_{ij}" border="0"/> is the random error. 

In this design it is assumed that the errors are identically independently distributed with with mean zero and variance <img src="http://latex.codecogs.com/gif.latex?\sigma^{2}" border="0"/>. Also, the observations are mutually independent with the mean and variance as displayed <img src="http://latex.codecogs.com/gif.latex?y_{ij}\sim&space;N(\mu+\tau_{i},\sigma^{2})" border="0"/>. The hypothesis test for this design can be written in two forms as displayed below:

<img src="http://latex.codecogs.com/gif.latex?\left\{\begin{matrix}H_{0}:&space;\mu_{1}=\mu_{2}=\mu_{3}\cdots=\mu_{a}\\H_{1}:&space;\mu_{i}\neq\mu_{j}\;\;\;\;\;\;\;\;\;\;\;\:\:\:\;\exists&space;(i,j)\end{matrix}\right&space;\Rightarrow\left\{\begin{matrix}H_{0}:&space;\tau_{1}=\tau_{2}=\tau_{3}\cdots=\tau_{a}\\H_{1}:&space;\tau_{i}=0\;\;\;\;\;\;\;\;\;\;\;\:\:\:\;\;\exists&space;(i)\end{matrix}\right" border="0"/>

The hypothesis test is done to evaluate if the treatment mean effects are equal as it can be seen on the right side or the effect of the treatments is zero on the left side. The treatment effect <img src="http://latex.codecogs.com/gif.latex?\tau_{i}" border="0"/> is the deviation of mean effect  <img src="http://latex.codecogs.com/gif.latex?\mu_{i}" border="0"/> from the overal mean <img src="http://latex.codecogs.com/gif.latex?\mu" border="0"/> as <img src="http://latex.codecogs.com/gif.latex?\tau_{i}=&space;\mu-\mu_{i}" border="0"/> and as aresult 

<img src="http://latex.codecogs.com/gif.latex?\sum_{i=1}^{a}\tau_{i}=&space;0" border="0"/>. 

The method of Analysis of Varaice is used to test the mean treatment effects. This name has derived from the fact that the toatl variability of the toatl mean can be partitioned in two parts as variability between treatments and variablity within treatments (i.e. sum of squares of errors).

<img src="http://latex.codecogs.com/gif.latex?SS_{Total}=SS_{Treatment}+SS_{Error}\Rightarrow\\\\\sum_{i=1}^{a}\sum_{j=1}^{n}(y_{ij}-\bar{y_{..}})^{2}=\sum_{i=1}^{a}\sum_{j=1}^{n}(\bar{y_{i.}}-\bar{y_{..}})^{2}+\sum_{i=1}^{a}\sum_{j=1}^{n}(y_{ij}-\bar{y_{i.}})^{2}" border="0"/>.

Since there are **a** treatments and **n** replicates, there are total of <img src="http://latex.codecogs.com/gif.latex?N=an" border="0"/> observations for this design. As a result the <img src="http://latex.codecogs.com/gif.latex?&space;SS_{Total}" border="0"/> has **N-1** degrees of freedom, <img src="http://latex.codecogs.com/gif.latex?&space;SS_{Treatment}" border="0"/> has **a-1**, and <img src="http://latex.codecogs.com/gif.latex?&space;SS_{Error}" border="0"/> has **N-a** degrees of freedom. The mean square errors can be obtained:

<img src="http://latex.codecogs.com/gif.latex?\begin{align*} & MS_{E}=&space;\frac{SS_{E}}{N-a}, & MS_{Treatment}=&space;\frac{SS_{Treatment}}{a-1}\end{align*}" border="0"/>

to evaluate the treatment effects on the response. The expected values of these quantities also can be obtained: 

<img src="http://latex.codecogs.com/gif.latex?\begin{align*} & E(MS_{E})=&space;\sigma^{2},&space;&&space;E(MS_{Treatment})=&space;\sigma^{2}+\frac{n\sum_{i=1}^{a}\tau_{i}}{a-1}\end{align*}" border="0"/>

As it can be observed if the treatment effects are zero, then both <img src="http://latex.codecogs.com/gif.latex?&space;MS_{E}" border="0"/> and  <img src="http://latex.codecogs.com/gif.latex?&space;MS_{Treatment}" border="0"/> are the unbiased estimate of  <img src="http://latex.codecogs.com/gif.latex?&space;\sigma^{2}" border="0"/>. Therefore, it can be concluded that the comparison between the <img src="http://latex.codecogs.com/gif.latex?&space;MS_{Treatment}" border="0"/> and <img src="http://latex.codecogs.com/gif.latex?&space;MS_{E}" border="0"/> can be used to do the hypothesis testing of this design.

The formal hypothesis testing can be done using the Cochrane's Theorem which implys that <img src="http://latex.codecogs.com/gif.latex?&space;\frac{SS_{E}}{\sigma^{2}}" border="0"/>  and <img src="http://latex.codecogs.com/gif.latex?&space;\frac{SS_{treatment}}{\sigma^{2}}" border="0"/> are indepndent chi-square random variables and as a result under the null hypothesis the ratio:

 <img src="http://latex.codecogs.com/gif.latex?F_{0}=&space;\frac{MS_{Treatment}}{MS_{E}}=\frac{SS_{Treatment}/a-1}{SS_{E}/N-a}" border="0"/>
 
has F distribution with (a-1) and (N-A) degrees of freedom. This is the test statistics for the hypothesis testing of no difference in the treatment means. By considering the expected mean squares, it can be seen that when the null hypothesis is false, then the expected value of  <img src="http://latex.codecogs.com/gif.latex?&space;MS_{Treatment}" border="0"/> is greater than expected avlue of <img src="http://latex.codecogs.com/gif.latex?&space;MS_{E}" border="0"/> and the null hypothesis needs to be rejected. 

## Factorial Design 
There are some experiments in which the effect of more than one factor needs to be evaluated. The most efficient design is Factorial design for this type of experiments. In this method all the combination of the factor levels are evaluated. for instance for a factorial design with two factors ``A`` with ``a`` levels and ``B`` with ``b`` levels, there are ``ab`` treatment for each replication. The main effect of a factors is the change in the response by change in the levels of that factor. The interaction between factors happens when the change in the response at the levels of one factor depends on the levels of other factor. The model Factorial experiment for two factros can be represented as:

<img src="http://latex.codecogs.com/gif.latex?Y_{ijk}=\mu+\tau_{i}+\beta_{j}+(\tau\beta)_{ij}+\epsilon_{ijk}" border="0"/>

for <img src="http://latex.codecogs.com/gif.latex?i=1,2,\cdots,a" border="0"/> ,  <img src="http://latex.codecogs.com/gif.latex?j=1,2,\cdots,b" border="0"/> , and <img src="http://latex.codecogs.com/gif.latex?k=1,2,\cdots,n" border="0"/>
, where <img src="http://latex.codecogs.com/gif.latex?\mu" border="0"/>
 is the overal mean effec, and <img src="http://latex.codecogs.com/gif.latex?\tau_{i}" border="0"/>
is the effect of ``i-th``  level of factor ``A``, <img src="http://latex.codecogs.com/gif.latex?\beta_{j}" border="0"/>
 is the effect of ``j-th``  level of factor ``B``, <img src="http://latex.codecogs.com/gif.latex?(\tau\beta)_{ij}" border="0"/>
 is the interaction effect of factors ``A`` and ``B`` and <img src="http://latex.codecogs.com/gif.latex?\epsilon_{ijk}" border="0"/> is the random error. Also, <img src="http://latex.codecogs.com/gif.latex?\sum_{i=1}^{a}\tau_{i}=0,\;\;\;\sum_{j=1}^{b}\beta_{j}=0,\;\;\;\sum_{i=1}^{a}(\tau\beta)_{ij}=\sum_{j=1}^{b}(\tau\beta)_{ij}=0" border="0"/>. The hypothesis test for this factorial expermient is :
 
 <img src="http://latex.codecogs.com/gif.latex?\left\{\begin{matrix}H_{0}:&space;\tau_{1}=\tau_{2}=\cdots=\tau_{a}\\H_{1}:\tau_{i}=0\;\;\;\;\;\;\;\;\;\;\;\:\:\:\;\;\exists&space;(i)\end{matrix}\right&space;\;\;\;\;\left\{\begin{matrix}H_{0}:&space;\beta_{1}=\beta_{2}=\cdots=\beta_{b}\\H_{1}:&space;\beta_{i}=0\;\;\;\;\;\;\;\;\;\;\;\:\:\:\;\;\exists&space;(i)\end{matrix}\right\;\;\;\;\left\{\begin{matrix}H_{0}:&space;(\tau\beta)_{ij}=&space;0\\H_{1}:&space;(\tau\beta)_{ij}\neq0\;\;\;\exists&space;(i)\end{matrix}\right" border="0"/>

These hypothesis are evaluating if the main effect of factors ``A`` and ``B`` and their interaction has effect on the response. These hypothesis can be tested using two-factor analysis of variance. The total variablility is partitioned as below:

<img src="http://latex.codecogs.com/gif.latex?SS_{T}=SS_{A}+SS_{B}+SS_{AB}+SS_{E}" border="0"/>

Where <img src="http://latex.codecogs.com/gif.latex?&space;SS_{T}" border="0"/> has <img src="http://latex.codecogs.com/gif.latex?&space;(abn-1)" border="0"/> degrees of freedom and <img src="http://latex.codecogs.com/gif.latex?&space;SS_{A}" border="0"/> , <img src="http://latex.codecogs.com/gif.latex?&space;SS_{B}" border="0"/> ,<img src="http://latex.codecogs.com/gif.latex?&space;SS_{AB}" border="0"/> ,<img src="http://latex.codecogs.com/gif.latex?&space;SS_{E}" border="0"/> has <img src="http://latex.codecogs.com/gif.latex?&space;(a-1)" border="0"/>, <img src="http://latex.codecogs.com/gif.latex?&space;(b-1)" border="0"/>,<img src="http://latex.codecogs.com/gif.latex?&space;(a-1)(b-1)" border="0"/>, and <img src="http://latex.codecogs.com/gif.latex?&space;ab(n-1)" border="0"/> degrees of freedom respectively. 

Mean square of the main effects, interaction, error and their expectations can be obtained as it was obtained for the single factor design. Also, the F statistic can be computed for each of the effects ``A``,``B``,``AB`` to decide if the null hypothesis must be rejected or accepted for these effects. 
 
## Two-level Factorial Designs
This method is represented by <img src="http://latex.codecogs.com/gif.latex?2^{k}"/>
 for ``K``  factors with two different levels as low and high for each factor. The simplest case of this type of method is the experiments with only two factors which will result is <img src="http://latex.codecogs.com/gif.latex?2^{2}=4" border="0"/>
 runs of experiment. This method of DoE will enable the experimenter to identify which main effects are significant. It also shows if there is any interaction among them and if it has effect on the response. The number of runs in this type of experiment increases when number of factor increases which will result in a more time consuming design. According to some experiments the effect of the higher order interactions of three and more factors tend to be small and can often be ignored. In this case to make the experiment more efficient another method of DoE, Fractional Factorial Design is recommended.
## Two-level Fractional Factorial Designs
Fractional Factorial Design for ``K`` factors and for ``1/p`` fraction <img src="http://latex.codecogs.com/gif.latex?2^{K-p}" border="0"/>
, can be used to reduce the number of runs. for instance the fractional design with ``K = 3`` and for ``p =1 `` which is denoted by <img src="http://latex.codecogs.com/gif.latex?2^{3-1}" border="0"/>
 is the half fraction of the Full Factorial design of <img src="http://latex.codecogs.com/gif.latex?2^{3}" border="0"/>. Therefore, instead of running the 8 treatments of the Full Factorial Design, half of it (i.e. 4 treatments) will be run. the half fraction can be the one where the interaction ``ABC`` is at the high level or at the low level.
As it can be seen in the image obtained from this website:

http://reliawiki.org/index.php/File:Doe7.34.png

![Test Image 1](http://reliawiki.org/images/c/c8/Doe7.34.png)


Figure (a) shows the Full Factorial design of three factors and figures (b) and (c) show the half fraction of it where interaction ``ABC`` is at its high and low level respectively. 

The interaction effect,``ABC``, is the generator or word for this type of design and since the intercept and this interaction effect are identical, it is written as ``I = ABC``. This equation is the defining relation for this design. From defining relation can conclude which effect are aliased or confounded. It can be seen that 

<img src="http://latex.codecogs.com/svg.latex?I\times\,B=B\times&space;ABC\Rightarrow\;B=AC" border="0">


 and as a result <img src="http://latex.codecogs.com/svg.latex?C=AB" border="0"/> and <img src="http://latex.codecogs.com/svg.latex?A=BC" border="0"/> . These equations show that the main effects ``A``, ``B`` and ``C`` are aliased with ``BC``, ``AC``, and ``AB`` respectively. 

Sometimes even half fraction design is very large because of the numebr of factors, and it needs a large number of runs. in this case the fraction of the design can be increased from a half fraction to a quarter fraction as

<img src="http://latex.codecogs.com/svg.latex?2^{K-2}=\frac{1}{2}\times(2^{K-1})=\frac{1}{4}(2^{K})"/>  

which is the half fraction of the previous fractional design.In this design at first half of the design with its generator(s) is selected and then from the first half the second half with its generator(s) will be selected. 

Althogh this method decreases the number of runs, as it was mentioed before, it makes the effects of some of the factors to be confounded with other effects. In this situationi it is very important to ensure that main effects and lower order interactions that are of interest to the experimenter are not aliased with other effects or there are few aliasing in the design. This can be done by considering the resolution of the Fractional Factorial design. The resolution of a Fractional Factorial design is the lowest oreder of the effect in the defining relation. For instance for a three factor Fractional Factorial Design as mentioned above the defining relation is ``I = ABC``, so as a result this is a design with resolution three. Resolution of a design is represented by Roman numbers. For instance the half fraction design with three factors and with this defining relation is written as <img src="http://latex.codecogs.com/gif.latex?2_{III}^{3-1}" border="0"/>. The resolution of a design is very important since the higher the resolution, the less confounding the lower effets will be with other effects. The resolution ``III`` and lower are not recommended since it will make the main effects to be confounded. 

There are designs with the same resolution whuch have different confouding structures. some have more lower effects alliased comparing to the other due to defining relation that is used. In this case the design with a resolution is recommended that has fewer cofounding factors than others and this is called a minimum aberration design. 

Sometimes a design with a resolution is selected and for the experimenter some of the lower effects that are important are aliased with other effects. In this case, those effect could be dealised with the method of foldover which can be explained in an example. For instance for the three factors Fractional design that was metioned above, three main factors were alised with the effect of two-factor interactions. In fact, if the two-factor effects considered to be unimportant then the main effects ``A``, ``B`` and ``C``can be obtained from ``A+BC``, ``B+AC``, and ``C+AB``. However, if this assumption does not hold then these main effects will be deliased by using the second half fraction of the design ``I = -ABC``. For the second half fraction design the main effects will be obtained from ``A-BC``, ``B-AC``, and ``C-AB``. Finally, the deliased main effect will be obtained by combining the effects obtained from both half fractions. In this process the Fractional Factorial design is augmented by the other fraction and this design is called a foldover design. 
Fractional Factorial design has this advantage that, it requires fewer runs depending on the design is selected. If some of the effects are confounded they can be delaised with foldover design or other Fractional Design with higher resolution can be used. In fact, in this method few effects are significant and and the final model is very simple with lower order terms. 

## Response Surface Method
When all of the significant factors are recoginsed from Fractional Factorial and Full Factorial designs then the RSM will be used to find the values for those factors at which the response will be optimized. There are two types of RSM models including first-oreder and second-order models. For the first-order model the method of Steepest Ascent method will be used to find the values of factors that optimize the response variable. On the other hand, if the first-order model does not fit well on the data then the second-order model will be used. There are two types of designs that can be used for second-order model including Central Composite and Box-Behnken Designs. When the design is decided then the second-order model will be fit to the data to find the values for the factors that optimize the response.
# Brief description of DoE for hyper-parameter tunning
In this experiment, Fractional Factorial and full Factorial designs were used to tune the hyper-parameters of a classification Random Forest model. The hyperparameters that were chosen to be tunned were ``ntree, mtry, replace, cutoff, classwt, nosesize, maxnodes``. For each of these hyper-parameters two levels were considered to be used in the design. Since the effect of seven factors needs to be evaluated on the performnace of the model, we need <img src="http://latex.codecogs.com/svg.latex?2^{7}=128" border="0"/> runs with only one replication. As a result, the Fractional Factorial design will be used which as mentioned before, is more efficient by using the fraction of the design and helps reduce the running time. Also, it is important to use the design with the resolution that keep the main effects not to be confounded with two-factor effects. Since a design with higher resolution is recommended the Fractional design <img src="http://latex.codecogs.com/gif.latex?2_{IV}^{7-2}" border="0"/> which will create a design with 32 runs was run. 

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
This is the first phase of this project for which the results of Fractional Factorial Design were obtained. In this phase the effect of seven hyper-parameters of Random Forest was evaluated on the perfomrmance of the model (i.e. BACC for adult dataset as classification problem). As it was mentioned above the Fractional Factorial Design of <img src="http://latex.codecogs.com/gif.latex?2_{IV}^{7-2}" border="0"/>  was selected. In this design the main effects are not alised with two-factor interactions, However the main effects are alised with three-factor interactions and two-factor interactions are alised with each other. It is required to see the results and decide if some of the main effects or interactions need to be de-alised. All the outputs of this experiments can be seen ``<LOCAL CLONED REPOSITORY>/ML-DoE/output/``. 

The experiments was done by dividing the dataset into train, valiadtion, and test sets and a 10-fold cross validation was performed. The test set will be used at the final stage to evaluate the performance of the selected model. In this phase it is required to investigate the results and decide if the result that was produced could be used to select the final model or further steps need to be taken. The R output file can be found here ``<LOCAL CLONED REPOSITORY>/ML-DoE/output/2020-05-01/stdout.R.runall`` and the graphs of main effects and interactions are displayed below.  

![Test Image 2](https://github.com/zaback-3958/ML-DoE/blob/master/001-fractional-factorial-design/output/2020-05-01/plot-main-effects-fractional-factorial-train-IV.png)

This graph shows that the main effects maxnodes, nodesize, and classwt are very significant, Also, Mtry shows an effect on the response, but not as strong as those three factors. 


![Test Image 3](https://github.com/zaback-3958/ML-DoE/blob/master/001-fractional-factorial-design/output/2020-05-01/plot-main-effects-fractional-factorial-valid-IV.png)

This graph also shows that the main effects maxnodes, nodesize, and classwt are very significant, then it can be seen that the effect of replace is less significant than those three. the effect of Mtry is not siginificant for cvalidation data.

The interaction graphs for train and validation data show which of them have effect on the response. 

![Test Image 5](https://github.com/zaback-3958/ML-DoE/blob/master/001-fractional-factorial-design/output/2020-05-01/plot-interactions-fractional-factorial-train-IV.png)

As it can be observed from the graph the interactions between the following factors are significant: replace:classwt,nodesize:cutoff,nodesize:maxnodes,classwt:cutoff,cutoff:maxnodes.  

![Test Image 6](https://github.com/zaback-3958/ML-DoE/blob/master/001-fractional-factorial-design/output/2020-05-01/plot-interactions-fractional-factorial-valid-IV.png)

This graph shows that the interactions between the following factors are significant:
replace:classwt, replace:maxnodes, nodesize:cutoff, nodesize:maxnodes, classwt:cutoff, cutoff:maxnodes   

After comparing the interaction effect of train and validation data it can be seen that the interaction of effect of replace:maxnodes is significant in the validation data, but not in the train data. 

As it was observed in the graphs for both train and validation data the main effect cutoff is not significant, but its interaction with other factors is significant. Since in this design the main effects are alised with higher order effects and two-factor interactions are alised with other two-factor interactions, it is required to de-alise the factor effects to find the real main effects and interactions that have significant effect on the response. In the next phase another method of Fractional Factorial Design and in the third phase the method of foldover design will be used to extract the significant main effects and interactions.
