library(dplyr)


## Getting DATA

# download zip file

zipUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if(!file.exists(zipFile)){
    download.file(zipUrl, zipFile, mode="wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
    unzip(zipFile)
}


##READING DATA
#training
trainingSubjects<-read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues<-read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity<-read.table(file.path(dataPath, "train", "y_train.txt"))

#test
testSubjects<-read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues<-read.table(file.path(dataPath, "test", "X_test.txt"))
testActivitity<-read.table(file.path(dataPath, "test", "y_test.txt"))

#features
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)

#activity_labels
activities<-read.table(file.path(dataPath,"activity_labels.txt"), as.is = TRUE)
colnames(activities)<-c("activity_id","activity_label")


##TASK1 - Merge the training and the test sets to create one data set

activity<-rbind(
    cbind(trainingSubjects, trainingValues, trainingActivity),
    cbind(testSubjects,testValues,testActivitity)
)
colnames(activity)<-c("subject", features[,2], "activity")

## remove raw data
rm(trainingSubjects,trainingValues,trainingActivity,
   testSubjects,testValues,testActivitity, features, labels)

##TASK2 - Extracts only the measurements on the mean and standard deviation for each measurement.

#Take only needed collum names
TaskCollums<-grepl("subject|activity|mean|std", colnames(activity))

#make new data
activity<-activity[,TaskCollums]


##TASK3
