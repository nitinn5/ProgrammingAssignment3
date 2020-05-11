# Coursera *Getting and Cleaning Data* course project

One of the most exciting areas in all of data science right now is wearable computing - see for example 
In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.

This repository contains the following files:

README.md, this file, which provides an overview of the data set and how it was created.

tidy_data.txt, which contains the data set.

CodeBook.md, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).

run_analysis.R, the R script that was used to create the data set.


## Creating the data set <a name="creating-data-set"></a>

The R script run_analysis.R can be used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

1) Download and unzip source data if it doesn't exist.
2) Read data.
3) Merges the training and the test sets to create one data set.
4) Extracts only the measurements on the mean and standard deviation for each measurement.
5) Uses descriptive activity names to name the activities in the data set
6) Appropriately labels the data set with descriptive variable names.
7) From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy_data.txt in this repository was created by running the run_analysis.R script.

