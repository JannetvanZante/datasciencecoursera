## Assignment week 4: Getting and cleaning data

The assignment of this week consists of getting and transforming data. 

The original data is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

It represents data collected from the accelerometers from the Samsung Calaxy S smartphone. A full description of is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#### The original data


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