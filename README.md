# Cpc-Position-curve-fitting
R scripts to query and fit the relation shapes between Avg CpC and Avg Position 

## Requirements

```
R version 3.4.4 (2018-03-15)
Platform: x86_64-apple-darwin15.6.0 (64-bit)
Running under: macOS High Sierra 10.13.4

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] data.table_1.10.4-3 coolblueshiny_0.0.1
```

## Content

* `./resources/query.R`: containing both queries for Belgium and a shortlisted campaigns for Netherlands

* `./Coefficients/`: (empty) output folder

* `estimate.R`: script which gets the selected query and fit the log models to each unique combination of
  `<Criteria, Adgroup, Device>` and stores by chunks of data the coefficients and the intercept in the output folder
  
* `get_curves.R`: reads as an input the coefficients stored in the corresponding folder and provides the cpcs given 
a position range and its deltas 
