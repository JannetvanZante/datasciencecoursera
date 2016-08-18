## Assignment week 4: Getting and cleaning data

The assignment of this week consists of getting and transforming data. 

The original data is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

It represents data collected from the accelerometers from the Samsung Calaxy S smartphone. A full description of is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#### The original data
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


#### I submitted four different files:

1. "README.md"
2. "CodeBook.md"
3. "run_analysis.R"
4. "AllDataMean.txt"

### 2. CodeBook.md
This codebook describes:

a. the data, original and resulting (same as above text)
b. the variables
c. the transformations performed to the data


### 3. run_analysis.R
This R-script contains the analysis to get, clean and transform the original data. The analysis consists of the nine steps described in the CodeBook.

### 4. AllDataMean
A textfile with the resulting tidy dataset. This file can be read into R with read.table("AllDataMean.txt", header = TRUE).

Have fun!