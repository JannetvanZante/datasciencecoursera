####################################################################################################
## 20160816:
## Analysis code ofthe assignment week 4, Coursera DataScience, Module 3: Getting and cleaning data
## Description of the data, the variables, and the transformations performed to the data, is given
## in the attached "CodeBook.md"
####################################################################################################

####################################################################################################
## 1. Download the original data
####################################################################################################

## If required, set your working directory

## Douwnload the data
if(!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/dataset.zip")

dateDownloaded <- date()
dateDownloaded  ## "Tue Aug 16 08:19:48 2016"


####################################################################################################
## 2. Investigate the original data
####################################################################################################

## I have chosen to unzip the files outside R

## Training data
TrainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
head(TrainData)
dim(TrainData)  ## 7352 rows, 561 columns

## Activity labels for training data
TrainLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
head(TrainLabels)
dim(TrainLabels) ## one activity for each observation in the training data
table(TrainLabels)

## Subjects belongng to training data
TrainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
head(TrainSubjects)
dim(TrainSubjects) ## one subject for each observation in the training data
table(TrainSubjects) ## 21 subjects (= 70% of 30) in the training set

## Test data
TestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
head(TestData)
dim(TestData)  ## 2947 rows, 561 columns

## Activity labels for test data
TestLabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
head(TestLabels)
dim(TestLabels) ## one activity for each observation in the test data
table(TestLabels)

## Subjects belongng to test data
TestSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
head(TestSubjects)
dim(TestSubjects) ## one subject for each observation in the test data
table(TestSubjects) ## 9 subjects (= 30% of 30) in the test set


## Description of the 561 variable names
Features <- read.table("./data/UCI HAR Dataset/features.txt")
head(Features)
dim(Features)


## Description of the 6 activities
Activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
head(Activities)
dim(Activities)


####################################################################################################
## 3. Extend the observations of the training set and the test set with the activity and the subject
##    they belong to
####################################################################################################

## I want to use cbind() to add the activity and the subject to each observation of the training set
## and the test set. 
## I first rename the "v1"-columns in the activity labels and the subjects to avoid that the 
## resulting sets contain three columns named "v1".

colnames(TrainLabels) <- c("activity")
colnames(TrainSubjects) <- c("subject")
TrainData <- cbind(TrainLabels, TrainData)
TrainData <- cbind(TrainSubjects, TrainData)
names(TrainData)  ## ok

colnames(TestLabels) <- c("activity")
colnames(TestSubjects) <- c("subject")
TestData <- cbind(TestLabels, TestData)
TestData <- cbind(TestSubjects, TestData)
names(TestData)  ## ok


####################################################################################################
## 4. Combine the training set and the test set to create one data set with all observations
####################################################################################################

AllData <- rbind(TrainData, TestData)
dim(AllData)  ## ok

## I remove all dataframes that I don't need anymore, to keep a clean workspace
ls() ## all object in my current workspace
rm("TestData", "TestLabels", "TestSubjects", "TrainData", "TrainLabels", "TrainSubjects")


####################################################################################################
## 5. Label the variables in the data set with the descriptive variable names available in 
##    "features.txt"
####################################################################################################

## From the lecture on editing text variables: Names of variables should be:
## - all lower case
## - descriptive
## - not duplicated
## - not have underscores, dots or white spaces

## In my opinion the variable names available in "features.txt" are descriptive.
## Moreover, in my opinion, the contrast between the lower and the upper case improves the 
## readibility of the names. Therefore, I did not change all names to lower case.

colnames(AllData) <- c("subject", "activity", as.vector(Features$V2))



####################################################################################################
## 6. Extract only the variables that represent measurements on the mean and the standard deviation
## for each measurement
####################################################################################################

## Make a vector of all columnnumbers that should be extracted
KeepColumns <- c(1, 2, grep("mean", colnames(AllData)), grep("std", colnames(AllData)))
AllData <- AllData[,KeepColumns]
dim(AllData)
colnames(AllData) ## ok


####################################################################################################
## 7. Replace the activity numbers 1..6 with the activity names available in "activity_labels.txt"
####################################################################################################

class(AllData$activity)  ## integer
class(Activities$V2) ## factor

for (i in 1:6) {
  AllData$activity[AllData$activity == i] <- tolower(as.character(Activities[i,2]))
  ## replace "_" with "-"
  AllData$activity[AllData$activity == i] <- gsub("_","-", AllData$activity[AllData$activity == i]) 
} 

AllData$activity <- gsub("_","-", AllData$activity) 
AllData$activity ## ok


####################################################################################################
## 8. Create a new dataset with the average of each variable for each activity and each subject
####################################################################################################

AllDataMean <- aggregate(AllData[,-(1:2)], by=list(AllData$activity, AllData$subject), FUN = mean, na.rm = TRUE)

## Aggregate has added two columns that can be renamed
colnames(AllDataMean)[1] <- "activity"
colnames(AllDataMean)[2] <- "subject"

## Reorder column 1 and 2
AllDataMean <- AllDataMean[,c(2,1,3:81)]


####################################################################################################
## 9. Write the dataset to a txt-file
####################################################################################################

## Note that columns 1 and  2 are in fact factors (subject consists of 30 levels, activity consists
## of 6 levels):
AllDataMean$subject <- as.factor(AllDataMean$subject)
AllDataMean$activity <- as.factor(AllDataMean$activity)

write.table(AllDataMean, file = "./data/UCI HAR Dataset/AllDataMean.txt", row.names = FALSE)
