## Start library(dplyr). Per the TA's response in the forum, for this project, 
## we don't need to ask to install package if this library is not available, 
## just add a requirement for this library in the readme file
library(dplyr)

###########  NOT USED  ##################
# Not required to download and extract the zip file
#
## Download data file from internet site
#download.file(
#     "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#     "cp_data.zip"
#     )

## Update progress on console
#print("Extracting zip file contents...",quote=FALSE)

## Unzip file in data directory (or the current working directory, if it's not the 
## data directory)
#unzip("cp_data.zip")
###########  NOT USED  ##################

## Update progress on console
print("Creating data tables...",quote=FALSE)

## Create data_tables from the original data set
dt_features<-tbl_df(read.table("./UCI HAR Dataset/features.txt"))
dt_activity_labels<-tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
dt_obs_test<-tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
dt_activities_test<-tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt"))
dt_subj_test<-tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt"))
dt_subj_train<-tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))
dt_activities_train<-tbl_df(read.table("./UCI HAR Dataset/train/y_train.txt"))
dt_obs_train<-tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))


#########################################################################
## Step 1: "Merges the training and the test sets to create one data set"
## Update progress on console
print("Processing...step 1",quote=FALSE)
#########################################################################

## Combine the test and train tables row-wise
##   for observations, subjects, and activities data tables
dt_obs<-rbind_list(dt_obs_test,dt_obs_train)
dt_subj<-rbind_list(dt_subj_test,dt_subj_train)
dt_activities<-rbind_list(dt_activities_test,dt_activities_train)

## Change dt_subj variable name from V1 to subject
dt_subj<-select(dt_subj,subject=V1)

## Change dt_activities variable name from V1 to activity
dt_activities<-select(dt_activities,activity=V1)

#########################################################################
## Step 2: "Extracts only the measurements on the mean and standard deviation 
##   for each measurement." 
## Update progress on console
print("Processing...step 2",quote=FALSE)
#########################################################################

## Select the features that contain the word "mean()" or "std()"
##   using glob2rs to create a reg expression string from normal wildcard
##   selection criteria then grep to select
grx<-glob2rx("*mean()*|*std()*")
dt_features_sel<-dt_features[grep(grx,dt_features$V2,ignore.case=TRUE),]

## Use the variable numbers from this vector to select the appropriate 
##   variables from the obs data table
dt_obs_sel<-select(dt_obs,dt_features_sel$V1)

#########################################################################
## Step 3: "Uses descriptive activity names to name the activities in the 
##   data set"
## Update progress on console
print("Processing...step 3",quote=FALSE)
#########################################################################

## Convert activity numbers to activity names in the activities data table
dt_activities$activity<-
     factor(dt_activities$activity,
            levels=dt_activity_labels$V1,labels=dt_activity_labels$V2)

#########################################################################
## Step 4: "Appropriately labels the data set with descriptive variable 
##   names."
## Update progress on console
print("Processing...step 4",quote=FALSE)
#########################################################################

## Rename feature descriptors for the selected features to human-readable
##   names
dt_features_sel$V2<-sub("tBody","timeBody",dt_features_sel$V2,)
dt_features_sel$V2<-sub("tGravity","timeGravity",dt_features_sel$V2,)
dt_features_sel$V2<-sub("fBody","frequencyBody",dt_features_sel$V2,)
dt_features_sel$V2<-sub("-mean","Mean",dt_features_sel$V2,)
dt_features_sel$V2<-sub("-std","StandardDeviation",dt_features_sel$V2,)
dt_features_sel$V2<-sub("Acc","Acceleration",dt_features_sel$V2,)
dt_features_sel$V2<-sub("Mag","Magnitude",dt_features_sel$V2,)
dt_features_sel$V2<-sub("BodyBody","Body",dt_features_sel$V2,)
dt_features_sel$V2<-sub("()","",dt_features_sel$V2,fixed=TRUE)
dt_features_sel$V2<-sub("MeanFreq","MeanFrequency",dt_features_sel$V2,)
dt_features_sel$V2<-sub("-X","X",dt_features_sel$V2,)
dt_features_sel$V2<-sub("-Y","Y",dt_features_sel$V2,)
dt_features_sel$V2<-sub("-Z","Z",dt_features_sel$V2,)

## Rename the variables in the obs file
names(dt_obs_sel)<-dt_features_sel$V2

#########################################################################
## Step 5: "From the data set in step 4, creates a second, independent tidy 
##   data set with the average of each variable for each activity and 
##   each subject."
## Update progress on console
print("Processing...step 5",quote=FALSE)
#########################################################################

## Add the subject variable (from dt_subj) so each obs includes the subject 
##   who provided the obs (necessary to group by subject)
##   (column-wise)
dt_obs_sel<-cbind(dt_obs_sel,dt_subj)

## Add the activity variable (from dt_activities) so each obs includes the
##   activity associated with the obs (necessary to group by activity)
##   (column-wise)
dt_obs_sel<-cbind(dt_obs_sel,dt_activities)

## Update progress on console
print("Creating tidy data file (name: tidydata.txt) in data directory...",
      quote=FALSE)

## Create tidy data table from results (created in the data directory)
##  grouped by subject and activity, then summarized using summarise_each with 
##  the mean() function
tidy_summary<-
     dt_obs_sel %>%
     group_by(subject,activity) %>%
     summarise_each(funs(mean))
write.table(tidy_summary,"tidydata.txt",row.name=FALSE)

###########  NOT USED  ##################
## Update progress on console
#print("Removing original zip file and extracted data directories...",
#    quote=FALSE)

## Remove the original zipfile downloaded, as well as the directory created
## during the zip extraction
#unlink("cp_data.zip")
#unlink("UCI HAR Dataset",recursive=TRUE)
###########  NOT USED  ##################

## Update progress on console
print("Done!",quote=FALSE)