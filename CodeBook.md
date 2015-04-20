Code Book
===================

source data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

the variables are described in features_info.txt features.txt.

the transformations to the original data sets are described as comments in the file "run_analysis.R" that contains R code to processes the data.

the output is a file called "averages.txt"
the rows are the variables described in features.txt.
The first 30 columns are the subjects of the experiments
The last 6 columns are the activities performed during the experiment.
The values are the average for the variable per column.