# Design-of-Experiments-for-Hypereparameter-tuning
The goal of this project is to use Design of Expeiments (DoE) to do the hyperparameter tuning for some machine learning models based on an article by Gustavo et al. in:

https://asu.pure.elsevier.com/en/publications/design-of-experiments-and-response-surface-methodology-to-tune-ma

The authors used DoE to do the hyperparameter tunning for Random Forest. They used Fractional Factorial Design and full Factorial Design to find the hyper-parameters with significant effect on the performance of the model. Then they used Response Surface Method (RSM) to find the values for those hyper-parameters (the ones that were recognised in the previous steps) that optimize the performance of the model. 

This work has been done according to the article to produce the results for Random Forest and then try to apply to some other machine learning models.

# General description of the Design of Experiments and some of its method
An experiment is a series of tests to identify the factors that have the greatest effect on the response. By Design of Experiment the number of factors, their ranges of values and number of times to run the espermients are determined to identify the relationship between the factors and response variable. Sometimes the effect of several factors on a response is identified by testing at different levels of factors one at a tiem which is useful only when there is no interaction between factors. However, since many times factors have interactions with eachother then that would be suggested to do the experiments by including all the factors. 
## Principles of Design of Experiments
There are three principles of design of experiments which are very important to run the experiments.
