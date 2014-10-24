Feature Selection 
=================

tidydata.txt is a tidy data set summary of data contained in the study "Human Activity Recognition Using Smartphones Dataset, Version 1.0."  This codebook for tidydata.txt is an adaptation of the codebook provided for the original study, "features_info.txt", available for reference in the folder "UCI HAR Dataset". The following is a summary of the changes made to the variables from the original study as displayed in the tidy data set, "tidydata.txt".

- The tidy data set is a subset of the variables from the original study.  The tidy set only includes original study variables that were a calculated mean (using mean()) or standard deviation (using std()) of observations in the study.

- The variable names in the tidy data set summarizing the study data have been changed to more human-friendly names.  This code book has been modified with the newly named variables found in the tidy data set, but also includes the original variable name (or stem in some portions of the descriptions) in [brackets] for reference when referencing the original study.

- All variables displayed in the tidy data set are means of the underlying variables from the original study.  For each of the 88 variable displayed, the column will include 180 values (means) of the overall data, grouped by 'subject' and 'activity'.

- As noted in the study README file, the values of all variables reported were normalized to the range -1 to 1. As a result, there are no units associated with the normalized values in the study, and there are no units in the tidy data values, as well.


The features selected for the tidy database come from the study's accelerometer and gyroscope 3-axial raw signals timeAccelerationXYZ [tAcc-XYZ] and timeGyroXYZ [tGyro-XYZ]. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAccelerationXYZ [tBodyAcc-XYZ] and timeGravityAccelerationXYZ [tGravityAcc-XYZ]) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerationJerkXYZ [tBodyAccJerk-XYZ] and timeBodyGyroJerkXYZ [tBodyGyroJerk-XYZ]). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerationMagnitude [tBodyAccMag], timeGravityAccelerationMagnitude [tGravityAccMag], timeBodyAccelerationJerkMagnitude [tBodyAccJerkMag], timeBodyGyroMagnitude [tBodyGyroMag], timeBodyGyroJerkMagnitude [tBodyGyroJerkMag]). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAccelerationXYZ [fBodyAcc-XYZ], frequencyBodyAccelerationJerkXYZ [fBodyAccJerk-XYZ], frequencyBodyGyroXYZ [fBodyGyro-XYZ], frequencyBodyAccelerationJerkMagnitude [fBodyAccJerkMag], frequencyBodyGyroMagnitude [fBodyGyroMag], frequencyBodyGyroJerkMagnitude [fBodyGyroJerkMag]. (Note the 'frequency' prefix to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'XYZ' is used to denote 3-axial signals in the X, Y and Z directions [the dash was removed in the updated variable names so '-X', '-Y', and '-Z' become simply 'X', 'Y', and 'Z' at the end of variable names for 3-axial signals].

timeBodyAccelerationXYZ			[tBodyAcc-XYZ]
timeGravityAccelerationXYZ		[tGravityAcc-XYZ]
timeBodyAccelerationJerkXYZ		[tBodyAccJerk-XYZ]
timeBodyGyroXYZ				[tBodyGyro-XYZ]
timeBodyGyroJerkXYZ			[tBodyGyroJerk-XYZ]
timeBodyAccelerationMagnitude		[tBodyAccMag]
timeGravityAccelerationMagnitude	[tGravityAccMag]
timeBodyAccelerationJerkMagnitude	[tBodyAccJerkMag]
timeBodyGyroMagnitude			[tBodyGyroMag]
timeBodyGyroJerkMagnitude		[tBodyGyroJerkMag]
frequencyBodyAccelerationXYZ		[fBodyAcc-XYZ]
frequencyBodyAccelerationJerkXYZ	[fBodyAccJerk-XYZ]
frequencyBodyGyroXYZ			[fBodyGyro-XYZ]
frequencyBodyAccelerationMagnitude	[fBodyAccMag]
frequencyBodyAccelerationJerkMagnitude	[fBodyAccJerkMag]
frequencyBodyGyroMagnitude		[fBodyGyroMag]
frequencyBodyGyroJerkMagnitude		[fBodyGyroJerkMag]

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

A list of the features selected for display in the tidy data set are included in the
file 'selected_features.txt' also available in the GitHub repo.  It contains the updated variable names for the selected variables in the tidy set, plus the number of the original variable located in 'features.txt', for reference.