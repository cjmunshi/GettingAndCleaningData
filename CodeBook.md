This File: CodeBook.md 
Author: Cyrus Munshi
Course: Getting and Cleaning Data  offered by http://www.coursera.com

This code book describes the creation and structure of the tidy data set produced by the R script: run_analysis.R.

Original Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data set consists of training data and test data located in the train and test subdirectories of the directory structure produced upon unzipping the source data file.  Both train and test data have the same 561 features named in the features.txt file.  A total of 10299 observations were recorded to the test and train data sets.  These observations were made for six activities listed in the activity_labels.txt file.  Each activity has a numeric code, called a class label.  The y_train.txt and y_test.txtr files contain the class labels for each of the respective observations.

The tidy data set was produced through a series of steps appearing in the run_analysis.R file and summarized below.
1. load the dplyr library
2. read the activity class labels and names (e.g. 1 WALKING, 2 WALKING_UPSTAIRS,...)
3. read the feature id's and names (e.g. 1 tBodyAcc-mean()-X, 2 tBodyAcc-mean()-Y,...)
4. load and merge (using rbind) the training and test class labels and data sets from y_train.txt, X_train.txt, y_test.txt, X_test.txt, respectively.  During loading the column names are specified using the feature names loaded in step 3.
5. Variables associated with the mean and standard deviation are extracted from the full data set.  The full data set contains 561 variables.  The extracted data set only includes 66 variables and was produced using a regular expression to identify varialbes having "mean()" or "std()" in their names.  This was achieved using the grepl function.
6. A new data set was then produced by adding a column of activity names to the extracted data set, so the appropriate activity name appears with each row of observations.
7. Next subject identifiers were added to each observation by first producing a full list of subjects through an rbind operation on the rows contained in the subject_train.txt and subject_test.txt files, then cbinding this result to the data set of step 6.
8. The first two columns of the tidy data set of step 7 are then switched before performing a group_by on the data set in order to group all observations first by activity and then by subject.
9. The summarize_each function is then performed on the data set of step 8 having 10299 observations.  Once summarized on the group_by columns the resulting data set has a total number of observations equal to the total number of combinations in the group_by columns.  Since there are 6 activities and 30 subjects and all subjects performed all activities a total of 6*30 = 180 observations appear in the final data set.
10. the final tidy data set of step 9 is written to a file.

The 66 variables of the final tiday data set are actually the mean of the original mean and standard deviation variables by activity class and subject of the original data sets and are named and appear in the tidy data set as listed below.

NOTE: 
Units for all Acceleration observations are in units of 1 Earth gravity or "g".  
All acceleration observation labels have "Acc" in their name.
Angular momentum variables have units of radians per second and contain "Gyro" in their names.

"tBodyAcc-mean()-X"
"tBodyAcc-mean()-Y"
"tBodyAcc-mean()-Z"
"tBodyAcc-std()-X"
"tBodyAcc-std()-Y"
"tBodyAcc-std()-Z"
"tGravityAcc-mean()-X"
"tGravityAcc-mean()-Y"
"tGravityAcc-mean()-Z"
"tGravityAcc-std()-X"
"tGravityAcc-std()-Y"
"tGravityAcc-std()-Z"
"tBodyAccJerk-mean()-X"
"tBodyAccJerk-mean()-Y"
"tBodyAccJerk-mean()-Z"
"tBodyAccJerk-std()-X"
"tBodyAccJerk-std()-Y"
"tBodyAccJerk-std()-Z"
"tBodyGyro-mean()-X"
"tBodyGyro-mean()-Y"
"tBodyGyro-mean()-Z"
"tBodyGyro-std()-X"
"tBodyGyro-std()-Y"
"tBodyGyro-std()-Z"
"tBodyGyroJerk-mean()-X"
"tBodyGyroJerk-mean()-Y"
"tBodyGyroJerk-mean()-Z"
"tBodyGyroJerk-std()-X"
"tBodyGyroJerk-std()-Y"
"tBodyGyroJerk-std()-Z"
"tBodyAccMag-mean()"
"tBodyAccMag-std()"
"tGravityAccMag-mean()"
"tGravityAccMag-std()"
"tBodyAccJerkMag-mean()"
"tBodyAccJerkMag-std()"
"tBodyGyroMag-mean()"
"tBodyGyroMag-std()"
"tBodyGyroJerkMag-mean()"
"tBodyGyroJerkMag-std()"
"fBodyAcc-mean()-X"
"fBodyAcc-mean()-Y"
"fBodyAcc-mean()-Z"
"fBodyAcc-std()-X"
"fBodyAcc-std()-Y"
"fBodyAcc-std()-Z"
"fBodyAccJerk-mean()-X"
"fBodyAccJerk-mean()-Y"
"fBodyAccJerk-mean()-Z"
"fBodyAccJerk-std()-X"
"fBodyAccJerk-std()-Y"
"fBodyAccJerk-std()-Z"
"fBodyGyro-mean()-X"
"fBodyGyro-mean()-Y"
"fBodyGyro-mean()-Z"
"fBodyGyro-std()-X"
"fBodyGyro-std()-Y"
"fBodyGyro-std()-Z"
"fBodyAccMag-mean()"
"fBodyAccMag-std()"
"fBodyBodyAccJerkMag-mean()"
"fBodyBodyAccJerkMag-std()"
"fBodyBodyGyroMag-mean()"
"fBodyBodyGyroMag-std()"
"fBodyBodyGyroJerkMag-mean()"
"fBodyBodyGyroJerkMag-std()"
