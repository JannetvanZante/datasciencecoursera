## Codebook assignment week 4: Getting and cleaning data

This codebook forms part of the assignment of week 4 of the Coursera training DataScience, Module 3: Getting and cleaning data.

This codebook describes:

1. the data
2. the variables
3. the transformations performed to the data



### 1. The data
#### The original data
The original data is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

It represents data collected from the accelerometers from the Samsung Calaxy S smartphone. A full description of is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data are available in two sets, a training set and a test set:

* the data consist of N rows, each row represents one observation
* the data consists of 561 columns, v1 to v561
* Each observation belongs to a specific activity (numbered from 1..6) and a specific subject (numbered from 1..30)


#### The resulting data
The resulting dataset gives the average of each variable for each activity and each subject:

* it consists of 180 (30 subjects * 6 activties) rows
* it consists of 81 columns
* the first column denotes the subject, the second column gives the activity
* the other 79 columns represent a subset of the original 561 variables, namely the measurements on the mean and the standard deviation
* the 79 variables are labeled with the descriptive variable names available in "features.txt"
* the activities are described according to "activity_labels.txt"
* the entries in the table give the average over all observations for that variable for the given subject and activity

In my opinion this set is tidy because it meets the priciples of this module (o.a. 1 var / column and 1 observation / row)


### 2. The variables
The variables in the original data give the:
* Triaxialacceleration from the accelerometer (total acceleration) and the estimated body acceleration, in standard gravity units
* Triaxial Angular velocity from the gyroscope, in radians / second
The variables are normalized and bounded within [-1,1]. 

The variables in the resulting dataset are a subset of the original variables (namely the measurements on the mean and the standard deviation) and give the average of each variable for each activity and each subject.

The variables are described extensively (and much better than I can ever do) in "features_info.txt". Therfore, I didn't copy these descriptions in this CodeBook, but I simply refer to the descriptions in "features_info.txt", which is in the downloaded data set.


### 3. The transformations performed to the data
The analysis to get, clean and transform the original data is available in the R script "run_analysis". The analysis consists of the following steps:

1. Download the original data
2. Investigate the original data
3. Extend the observations of the training set and the test set with the activity and the subject they belong to
4. Combine the training set and the test set to create one data set with all observations
5. Label the variables in the data set with the descriptive variable names available in "features.txt"
6. Extract only the variables that represent measurements on the mean and the standard deviation for each measurement
7. Replace the activity numbers 1..6 with the activity names available in "activity_labels.txt"
8. Create a new dataset with the average of each variable for each activity and each subject
9. Write the dataset to a txt-file