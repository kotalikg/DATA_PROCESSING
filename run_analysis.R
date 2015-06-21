
##0/A. step: download and unzip manually the data into your working directory for the project from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 

##0/B. step: load the relevant .txt data from working directory into R (no header!)

#shared
features <- read.table("features.txt", header=FALSE)
activities <- read.table("activity_labels.txt", header=FALSE)

#train data
subjecttrain <- read.table("subject_train.txt", header=FALSE)
xtrain <- read.table("X_train.txt", header=FALSE)
ytrain <- read.table("y_train.txt", header=FALSE)

#test data
subjecttest <- read.table("subject_test.txt", header=FALSE)
xtest <- read.table("X_test.txt", header=FALSE)
ytest <- read.table("y_test.txt", header=FALSE)


##1 step: Merges the training and the test sets to create one data set

#name the variables using features data (both train/test)
names(xtrain) <- features$V2
names(xtest) <- features$V2

#fit the activity info (both train/test)
names(ytrain) <- c("ActivityCode")
trainmerge <- cbind(ytrain, xtrain)

names(ytest) <- c("ActivityCode")
testmerge <- cbind(ytest, xtest)

#fit the subject info (both train/test)
names(subjecttrain) <- c("SubjectCode")
trainmerge <- cbind(subjecttrain, trainmerge)

names(subjecttest) <- c("SubjectCode")
testmerge <- cbind(subjecttest, testmerge)

#merge the complete train and test datasets
fulldata <- rbind(trainmerge, testmerge)


##2 step: Extracts only the measurements on the mean and standard deviation for each measurement.

#select variables containing mean() term exactly (fixed = TRUE)
meanset <- fulldata[grep("mean()", names(fulldata), fixed = TRUE)]

#select variables containing std() term exactly (fixed = TRUE)
stdset <- fulldata[grep("std()", names(fulldata), fixed = TRUE)]

#select variable with subject / activity data
subact <- fulldata[1:2]

#create the requested extraction
mean_std_set <- cbind(subact, meanset, stdset)


##3 step: Uses descriptive activity names to name the activities in the data set.

#rename and merge activity names using activities dataframe based on activity_labels.txt (sorting not needed, sort = FALSE) 
names(activities) <- c("ActivityCode", "ActivityName")
mean_std_set <- merge(mean_std_set, 
                      activities, 
                      by.x="ActivityCode",
                      by.y="ActivityCode",
                      all = TRUE, 
                      sort = FALSE)

#shape the result
actlab <- mean_std_set[69]
subjlab <- mean_std_set[2]
measuredata <- mean_std_set[3:68]
mean_std_lab_set <- cbind(subjlab, actlab, measuredata)


##4 step: Appropriately labels the data set with descriptive variable names. 

#done at 1 step


##5 step: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#calculate average of each variable by subject and activity
tidydata <- aggregate(mean_std_lab_set[, 3:68], 
                      list(SubjectCode = mean_std_lab_set$SubjectCode, 
                           ActivityName = mean_std_lab_set$ActivityName),
                      mean)

#reorder the results by subject and activity
library(plyr)
tidydata <- arrange(tidydata, SubjectCode, ActivityName)

#modify the variable names to indicate the content (average values)
nameold <- names(tidydata)
namenew <- c(nameold[1:2], sub("(?<=.{0})", "Avg_", nameold[3:68], perl=TRUE ))
names(tidydata) <- namenew

#write results into text file, as it was requested (row.name=FALSE)
write.table(tidydata, file = "tidydata.txt", row.name = FALSE)