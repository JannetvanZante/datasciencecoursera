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

The original data are available in two sets, a training set and a test set. The data are structured like this:

| | v1 | v2 | v3 | ... | v561 |
|-|----|----|----|-----|-----------------------------------
| obs 1 | x | x | x | ... | x |
| obs 2 | x | x | x | ... | x |
| ... | | | | ... | |
| obs N | x | x | x | ... | x |

Each observation belongs to a specific activity (numbered from 1..6) and a specific subject (numbered from 1..30)

#### The resulting data
The resulting dataset gives the average of each variable for each activity and each subject and looks like:


| subject | activity | v1 | v2 | v3 | ... | v79 |
---------------------------------------------------------------------
| 1 | walking | mean | mean | mean | ... | mean |
| 1 | walking-upstairs | mean | mean | mean | ... | mean |
| ... | | | | | ... | |
| ... | | | | | ... | |
| 30 | laying | mean | mean | mean | ... | mean |


where:

* v1 .. v79 are a subset of the original v1 ... v561, namely the measurements on the mean and the standard deviation
* v1 .. v79 are labeled with the descriptive variable names available in "features.txt"
* the activities are described according to "activity_labels.txt"

In my opinion this set is tidy because it meets the priciples of this module (o.a. 1 var / column and 1 observation / row)

### 2. The variables
The variables in the original data give the:
* Triaxialacceleration from the accelerometer (total acceleration) and the estimated body acceleration, in **standard gravity units**
* Triaxial Angular velocity from the gyroscope, in **radians / second**
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