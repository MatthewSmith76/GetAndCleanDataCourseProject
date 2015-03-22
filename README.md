# Course Project for Getting and Cleaning Data
This repository is designed to fullfill the requirements for the Course Project for "Getting and Cleaning Data" run by Coursera.

The original data for the project is located:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data has been collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In the analysis script **run_analysis.R** is contained within this repo.  following operations have
been performed on the original data:

1. One data table is created from the training and the test sets  
2. We only consider measurements on the mean and standard deviation for each measurement. 
3. We employ descriptive activity names for each activities in the data set 
4. Appropriately label each variable in the data table. 
5. A new tidy data set with the average of each variable for each activity and each subject.
