# Design-of-Experiments-for-Hypereparameter-tuning
The goal of this project is to use Design of Expeiments (DoE) to do the hyperparameter tuning for some machine learning models based on an article by Gustavo et al. in:

https://asu.pure.elsevier.com/en/publications/design-of-experiments-and-response-surface-methodology-to-tune-ma

The authors used DoE to do the hyperparameter tunning for Random Forest. They used Fractional Factorial Design and full Factorial Design to find the hyper-parameters with significant effect on the performance of the model. Then they used Response Surface Method (RSM) to find the values for those hyper-parameters (the ones that were recognised in the previous steps) that optimize the performance of the model. 

This work has been done according to the article to produce the results for Random Forest and then try to apply to some other machine learning models. 
