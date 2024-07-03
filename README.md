# Embeded Standard Setting

This repository has codes that implement several Embedded Standard Setting (ESS) methods(Lewis & Cook, 2020). 
ESS is a new standard new standard setting methodology designed to calculate cut scores through the optimization of the relationship between item alignment to Achievement Level Descriptors (ALDs) and item difficulty. 


## Description

The codes in this repository implement three methods to compute cut scores for ESS: 
1) Minimize the inconsistencies between rater assigned item achievement levels and ESS-determined item achievemnet levels
2) Mean & Midpoint method
   * First, calculate the mean difficulty for items at each performance level.
   * Second, deetermine cut scores by locating the midpoints between the mean values of adjacent levels.
3) Receiver Operating Characteristic (ROC) curve method
   * Identify the cut that optimze prediction by striking a balance between true positives and true negatives. 

## Getting Started

### Dependencies

* numpy
* sklearn.metrics
* scipy.stats

### Installing

* The ESS_ROC and ESS_counts_MM files implement the three cut identification methods. 
* The ESS_graphs file plot relevant graphs. 



