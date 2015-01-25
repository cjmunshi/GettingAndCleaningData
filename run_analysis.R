# ======================================================
#
# Author: Cyrus Munshi
# Date: January 24, 2015
#
# Coursera.org Course Title: Get and Clean Data
#
# Course Project
#
# filename: run_analysis.R
#
# source data: 
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# Summary of Steps:
#
# 1.Merge the training and the test sets to create one data set.
# 2.Extract only the measurements on the mean and standard deviation for each 
#   measurement. 
# 3.Use descriptive activity names to name the activities in the data set
# 4.Appropriately label the data set with descriptive variable names. 
# 5.From the data set in step 4, create a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.
# 
# ======================================================

# --------------------------------
# <<0>> 
# Initialization
# --------------------------------

# set working directory to top-level of unzipped dataset.
setwd("D:\\Coursera\\GetAndCleanData\\data\\UCI HAR Dataset")

# load r libraries
library(dplyr)

# load descriptive activity names (WALKING, WALKING_UPDTAIRS,...)
activityLabels<- read.table("activity_labels.txt", 
                             col.names=c("classLabel","activityName"),
                             stringsAsFactors=FALSE)

# load features (variable names e.g. "tBodyAcc-mean()-X")
features<- read.table("features.txt",
                      col.names=c("featureId","featureName"),
                      stringsAsFactors=FALSE)

# -------------------------------------------------
# <<1>> 
# Load and Merge training and test data sets 
# -------------------------------------------------
 
trainingLabels<- read.table("train\\y_train.txt",
                               col.names=c("classLabel"))

trainingSet<- read.table("train\\X_train.txt",skip=0, 
                          colClasses="numeric",
                          col.names=features$featureName,
                          check.names=FALSE)
  
testLabels<- read.table("test\\y_test.txt",
                        col.names=c("classLabel"))

testSet<- read.table("test\\X_test.txt",skip=0, 
                      colClasses="numeric",
                      col.names=features$featureName,
                      check.names=FALSE)

fullSet<- rbind(trainingSet,testSet)

fullLabels<- rbind(trainingLabels,testLabels)

# -------------------------------------------------
# <<2>> 
# Extract only the measurements on the mean and 
# standard deviation for each measurement.
# -------------------------------------------------

# column names follow a naming standard indicating the 
# type of data present.  Columns having mean and 
# standard deviation data have column names containing "mean()" and "std()"

extractedSet<-   
fullSet[,
         features$featureName[
           which(grepl("(^.*mean\\())|(^.*std\\())",
                       features$featureName,
                       ignore.case=TRUE))
           ]]

length(names(extractedSet))  # I identify 66 columns in the extracted set

ncol(extractedSet)

# -------------------------------------------------
# <<3>> 
# Use descriptive activity names to name the 
# activities in the data set.
# -------------------------------------------------

# Add a column providing the activity name for each row.
# fullLabels provides coded activity names for each row.
# add column to beginning of extractedSet

extractedSetWithActivityNames<-
  cbind(
    "activityName"=activityLabels$activityName[fullLabels$classLabel],
    extractedSet
    )

# -------------------------------------------------
# <<4>> 
# Appropriately label the data set with descriptive 
# variable names.
# -------------------------------------------------

# NOTE: this has already been performed in step <<1>>
#       when col.names were set for the trainingSet and 
#       testSets to be the apperopriate featureNames.

# -------------------------------------------------
# <<5>>
# From the data set in step 4, create a second, independent tidy 
# data set with the average of each variable for each activity 
# and each subject.
# -------------------------------------------------

# First add new column of subject data
trainSubject<- read.table("train\\subject_train.txt",
                            col.names=c("subjectId"))

testSubject<- read.table("test\\subject_test.txt",
                          col.names=c("subjectId"))

fullSubject<- rbind(trainSubject,testSubject)

indepTDS<- cbind(fullSubject,extractedSetWithActivityNames)

# Rearrange first two columns, so that column order matches
# intended grouping
x<-c(2,1); q<-ncol(indepTDS); y<-c(3:q); z<-c(x,y)

indepTDS<- indepTDS[z]

# Group by activity and subject and obtain mean of observations 
# for each variable

indepTDS<- group_by(indepTDS,activityName,subjectId)

indepTDSMean<-summarise_each(indepTDS,funs(mean))

# -------------------------------------------------
# <<Submital>>
# Write tidy dataset from step 5 out to a file
# using write.table() and row.names=FALSE.
# -------------------------------------------------

write.table(indepTDSMean,file="courseProjectTidyDataSet.txt", row.names=FALSE)


write.table(features$featureName[
  which(grepl("(^.*mean\\())|(^.*std\\())",
              features$featureName,
              ignore.case=TRUE))],file="extractedFeatures.txt",row.names=FALSE)

