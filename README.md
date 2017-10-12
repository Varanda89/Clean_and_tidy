This repository include the following files:

README.md - Current file

Run_analysis.R - This R scripts perform a series of actions described below upon the Data Sets provided in:

   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.
   
   It must be necessary downloading and unzip it in the working directory, otherwise it will not work
   
   Package dplyr must have been previously installed
   
 CodeBook.md - It explains the output variables for Run_analysis.R scripts
 
*************
The following actions are performed in Run_analysis.R:

Train and Test datasets are merged into one with subjects and activities.

Measurements on the mean and standard deviation for each measurement are only taken

Descriptive activity names are used to name the activities in the data set

Descriptive variable names are given for Data

A tidy data set with the average of each variable for each activity and subject is exported: summary.txt see CodeBook.md for more info
