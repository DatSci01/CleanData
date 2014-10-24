==================================================================
Course Project for Getting and Cleaning Data
run_analysis.R script to produce the tidy data set "tidydata.txt"
==================================================================
Student:  DatSci01
==================================================================

This course project was to provide a tidy summary of smartphone activity data 
made available in the study "Human Activity Recognition Using 
Smartphones Dataset, Version 1.0."  The original study's README.txt 
describing the smartphone study methodology and the data generated is 
available for reference in the folder "UCI HAR Dataset".

The "run_analysis.R" script contains remarks that describe the script's actions. 
The following provides additional details and background information about 
script processing to produce the tidy data set, "tidydata.txt". Both 
"run_analysis.R" and "tidydata.txt" are included in the GitHub repo.

"run_analysis.R" requires the library "dplyr".  Per TA comments in the 
forum, this script does not include code to install this library if it has 
not been previously installed, but it does load this library.

run_analysis.R includes code to download and unzip the data from the site 
where is it located, but this code has been disabled since the project instructions indicate we can assume the folder "UCI HAR Dataset" (and subfolders) is available unzipped in the working directory. Code to delete the data files at the end of the script is also present but has also been disabled. As a result, the script requires the data folder "UCI HAR Dataset" (and subfolders) containing the project data be available in the working 
directory when this script is executed. Those folders are left unchanged after
script processing completes (the 'tidydata.txt' file produced by the script is written to the working directory, not the "UCI HAR Dataset" folder).

Because the process of reading the datafiles and processing the data can be 
lengthy, I also included several print statements throughout the script so 
progress is shown on the console as the script executes (mainly so impatient 
individuals like myself have something to watch as the script executes).

The script initially populates the following data tables from the data 
provided:

From the 'UCI HAR Dataset' folder:

dt_features: read from 'features.txt', a list of the names of the original 
study variables (the names in dt_features are subsequently renamed in the script
to make them more useable and to satisfy a project requirement to practice string 
manipulation).

dt_activity_labels: read from 'activity_labels.txt' a list of the names of 
the various activities observed during the study ("WALKING", etc.)

From the 'test' subfolder:

dt_obs_test: read from 'X_test.txt', one of the main tables of study data 
(the other is 'X_train.txt'--see below). This table consists of the 561 variables 
observed for the test group over 2947 observations).

dt_activities_test: read from 'y_test.txt', a 2947 x 1 table of the activity 
associated with each data record in 'X_test.txt'. These data are numerical 
associated with the number assigned each activity in 'actvity_labels.txt'.

dt_subject_test: read from 'subject_test.txt', this 2947 x 1 table contains the id number of the individual associated with each data record in 'X_test.txt'.

From the 'train' subfolder:

dt_subj_train, dt_activities_train, and dt_obs_train were read in the same 
manner as data from the 'test' folder. Each of these tables contain 7352 observations, with the same variables as the test data tables.

Based on the project requirements, data from the 'Inertial Signals' 
subfolder (in both the 'train' and 'test' subfolders) were not relevant to 
the tidy data set, so they were not used. Essentially, the 'Inertial Signals' 
data were used to create the data in the X_train and X-test files but are not 
necessary to summarize the X-train and X_test data. As a result, creation of 
the tidy data table did not require use of the data from the 'Inertial 
Signals' folders.

'run_analysis.R' then accomplishes the 5 steps outlined in the project
description.

1. "Merges the training and the test sets to create one data set."

Using rbind_list, the script combines the pertinent train and test tables into 3 combined tables: a 10299 x 561 table called 'dt_obs' (observations), a 10299 x 1 table called 'dt_subj' (the ids for the subjects accomplishing the obs), and a 10299 x 1 table called 'dt_activities' (the ids for the activities associated with the obs).

Following creation of these data tables, the 'dt_subj' and 'dt_activities' variable name ('V1') was renamed to 'subject' and 'activity', respectively.

2. "Extracts only the measurements on the mean and standard deviation for each measurement."

The script uses grep(), using a search criteria string created with glob2rs(), to 
search and extract all variables found in the list of feature variables 
('dt_features', a 561 x 2 table) which include the word 'mean()' or 'std()' and put the selected variables into 'dt_features_sel', a 66 x 2 table.  I limited the search to only variables that directly represented 'mean()' or 'std()' values, excluding other variables which included only indirect mean calculations.  For example, 'angle(tBodyAccMean,gravity)' is a variable derived, in part, from another variable with a direct measure of mean(), 'tBodyAcc-mean()' (included in the tidy set).  'angle(tBodyAccMean,gravity)' itself is not the mean of several measurements, it is a direct measure between one quantity and the previously calculated mean value ('tBodyAcc-mean()'). As a result, I didn't believe it fit the project requirement outlined in step 2 of the instructions for mean and standard deviation of measurements.  In addition, I was concerned that if variables with indirect mean measurement were included, there may be some danger of over-emphasizing certain variables in the data, since, as in this example, the value of 'tBodyAcc-mean()' is actually included in more than one variable.  Put another way, including variables like 'tBodyAcc-mean()' along with other variables which include this variable in their calculation ('angle(tBodyAccMean,gravity)', in this case), might make it difficult to identify and isolate the effect of 'tBodyAcc-mean()' in subsequent analyses using the tidy data set.

After selecting the appropriate variables (66 variables), the script then uses the selections as criteria to select from the main table only these 66 variables, creating a new data table called 'dt_obs_sel', a 10299 x 66 table.

3. "Uses descriptive activity names to name the activities in the data set."

To display the name of the activity in place of the id in 'dt_activities', the 
'V1' variable of 'dt_activities' was made into a factor using factor() with 
the dt_activity_labels variables 'V1' and 'V2' as factor levels and factor labels, respectively.

4. "Appropriately labels the data set with descriptive variable names." 

At this point, as directed in the project instructions, the script modifies 
the variable names in 'dt_features_sel' to make them more "human-friendly'.  Using sub() for string search and manipulation, the script removes all parentheses and dashes and expands all abbreviations. For example, the original study authors used 'f' to prefix frequency variables and 't' to prefix time variables. The script expands these to show 'frequency' and 'time', respectively. Similarly, 'Acc' is expanded to 'Acceleration' and 'Mag' is expanded to 'Magnitude'.  Some variables had the word 'Body' repeated (ie, 'BodyBody'), which was also corrected.  All changes were made in accordance with the variable naming conventions 
described in the lectures, except for the use of capital letters in the 
variable names.  I kept capital letters in the variable names (instead of 
all lower case) to divide the resulting very long variable names into a more 
readable form.

5. "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

To accomplish this, the script first uses cbind() to add 'dt_subj' and 'dt_activities' to the main data table 'dt_obs' (creating a 10288 x 68 table) so the subject id and activity associated with each observation is available for grouping the data. Then, the script creates a tidy data set, grouping 'dt_obs' by subject and activity and summarizing each grouping with the mean of the group.  This results in a data set with 180 rows and 68 variables. Each data item is the mean of the data for that variable, grouped by each activity and subject. The tidy data set created has been written to a table called "tidydata.txt" provided in the GitHub repo. It can be read in R using the read.table command [read.table("tidydata.txt",header=TRUE)].