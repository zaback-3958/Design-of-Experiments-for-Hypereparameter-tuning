# Design-of-Experiments-for-Hypereparameter-tuning
The goal of this project is to use Design of Expeiments (DoE) to do the hyperparameter tuning for some machine learning models based on an article by Gustavo et al. in:

https://asu.pure.elsevier.com/en/publications/design-of-experiments-and-response-surface-methodology-to-tune-ma

The authors used DoE to do the hyperparameter tunning for Random Forest. They used Fractional Factorial Design and full Factorial Design to find the hyper-parameters with significant effect on the performance of the model. Then they used Response Surface Method (RSM) to find the values for those hyper-parameters (the ones that were recognised in the previous steps) that optimize the performance of the model. 

This work has been done according to the article to produce the results for Random Forest and then try to apply to some other machine learning models.

# General description of the Design of Experiments and some of its method
An experiment is a series of tests to identify the factors that have the greatest effect on the response. By Design of Experiment the number of factors, their ranges of values and number of times to run the experiments are determined to identify the relationship between the factors and the response variable. Sometimes the effect of several factors on a response variable is identified by testing at different levels of factors one at a time which is useful only when there is no interaction between factors. However, since many times factors have interactions with each other then that would be more effective to do the experiments by including all the factors. There are several methods for DoE which are very useful in different context and according to the situation. In this part the methods that was used for hyperparameter tuning will be discissed.
## Two-level Factorial Designs
This method (2\^k factorial experiment) includes factors with 2 levels which is identified by low and high levels . The simplest case of this type of method is the experiment with two factors which will result is 2^2 runs of experiments. 

\[ a_1^2 + a_2^2 = a_3^2 \]

