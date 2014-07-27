
Input
=====
Download the data zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The files contain data recorded from experiments with 30 volunteers wearing a smartphone (Samsung Galaxy S II) on the waist.

The run_analysis.R script reads in the following relevant files and stores them in variables with matching names:
* subject_test.txt
* X_test.txt
* y_test.txt
* subject_train.txt
* X_train.txt
* y_train.txt
* features.txt
* activity_labels.txt

Output
======
The run_analysis.R script creates a file named tidy_data.txt.  The first column of the tidy_data.txt file is "subject_id" with contains the subject id originally found in the subject_test and subject_train files.  The next column of the tidy_data.txt file is "activity_title" describes the one of six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.  The remaining columns contain the mean of the values defined in the features.txt file, the column names are based on those names. 

Process
=======
The run_analysis.R Script:
* Reads in all relevant files
* Gets feature and activity titles
* Sets test and train names to feature titles
* Strips out all fields that are not mean or standard deviation
* Combines X test and training rows
* Adds a second column of activity titles
* Combines Y test and training rows
* Sets activity names
* Combines subject test and train ids
* Combines subjects, activities and features into one data table
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject
* Outputs tidy_data to a file named tidy_data.txt.