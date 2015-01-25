# GettingAndCleaningData
Repository for Coursera.org Getting And Cleaning Data course project.

--------------------------------
Repository files and Instructions
--------------------------------

run_analysis.R
Purpose: produce tidy data set required for Coursera.org course project.
Source Data:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Output file: tidy data set written to file courseProjectTidyDataSet.txt via write.table procdedure.
Execution Instructions:
1. download and unzip source data
2. place run_analysis.R into root of unzipped source data file directory structure.
3. review comments in run_analysis.R file.
4. edit run_analysis.R file and set the working directory to the same directory the file is place in.
5. confirm you have loaded the dplyr R package.  This may be performed in RStudio->Tools->Install Packages.
6. execute the run_analysis.R script.
7. review the courseProjectDataSet.txt file produced by the script and containing the tidy data set.

README.md
This file.  Describes files in the repository.

CodeBook.md
Code book for courseProjectTidyDataSet.txt file.  The code book describes the variables and data contained in the tidy data set file.
