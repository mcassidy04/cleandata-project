run_analysis Data Selection and Generation 
=================

The measurements and calculations summarized in this data set are based on data from an experiment in which cell phone sensor readings were collected on 6 specified activities by 30 subjects.
The 'run_analysis.txt' data set captures the average values of the calculated mean() and standard deviation (std()) measures across multiple observations for each of these subjects performing each activity. 
The actual number of observations for each grouping varies and is not captured here. However, the multiple estimated values of mean() and std() are averaged by activity and subject to summarize.
From the original data set of 10299 observations across 561 measures, the summary data constitutes 180 rows(6 activities by 30 subjects) of 66 averaged measures each.

Source data:
Descriptions of the originating experiment and the source data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip but a brief extract of significant description follows:

The measurements/calculations included were described in documentation for original data sets as: 
"...the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
..."
Only the last two of these were of interest in this analysis.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Data files:
Multiple files were used from 'Source data' referenced above. Files used are the following: 

- 'features.txt': List of all features. 

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set. 7352 rows/observations of 561 columns/(sensor measures and estimated/calculated values) for each observation for selected set of subjects.

- 'train/y_train.txt': Training labels. 7352 rows of single number value. Each row identifies the activity being performed for each window sample. Its range is from 1 to 6.

- 'test/X_test.txt': Test set. 2947 rows/observations of 561 columns/(sensor measures and estimated/calculated values) for each observation for selected set of subjects.

- 'test/y_test.txt': Test labels. 2947 rows of single number value. Each row identifies the activity being performed for each window sample. Its range is from 1 to 6.

- 'train/subject_train.txt': 7352 rows of single number value. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt':  2947 rows of single number value. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Data set generated:
- 'run_analysis.txt': 180 rows of 68 variables
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Scripted method for generating run_analysis text:

A. Combine distinct data files to create data set with all required variables for each observation 
	1. Load selected columns from 2947 observations from 'test/X_test.txt' into a data frame.
	2. Load same selected columns from 7352 observations from 'train/X_train.txt' into a data frame.
	3. Add columns/variables for activity and bind values from corresponding label data -- 2947 values from 'test/y_test.txt' to first data frame and 7352 rows from 'train/y_train.txt' to second.s
	4. Add columns/variables for subject and bind values from corresponding subject data -- 2947 values from 'test/subject_test.txt' to first data frame and 7352 rows from 'train/subject_train.txt' to second.
	5. Apply simplified meaningful names to variables in test and train data sets -- facilitates combining and later analysis.

B. Concatenate test and train data sets into single complete set of observations
	1. Simple rbind appends second data frame to first with applied variable names.
	2. Replace activity numbers with descriptive names
	
C. Output data frame to text file 

