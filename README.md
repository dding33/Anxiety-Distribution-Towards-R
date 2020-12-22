# Overview

This repo contains code and data for estimating student's anxiety level towards using R at the University of Toronto. It was created by Yiqu Ding. The purpose is to create a report that summarizes the results of a statistical model that we built. Some data is unable to be shared publicly. We detail how to get that below. The sections of this repo are: inputs, outputs, scripts.

Inputs contain data that are unchanged from their original:

- [Survey data - The full survey data is not available, see next section ]
- [census.csv - this is a simulated post-stratification data set.]

Outputs contain data that are modified from the input data, the report and supporting material. You will find these in the data folder:

- [clean_data.csv - this is reduced version of the survey data and is everything you need for this report.] 
- [cell_counts.csv - this is data summarizing all the cells for post-stratification.]

You will also find four data sets created for subpopulation post-stratification for each variable: sex_prop.csv, program_prop.csv, cgpa_prop.csv and code_prop.csv.

Scripts contain R scripts that take inputs and outputs and produce outputs. These are:

- 01_data_cleaning-survey.R
- 02_data_data_cleaning-post-strat.R