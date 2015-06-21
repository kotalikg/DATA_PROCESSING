---
title: "README.md"
output: html_document
---

##Purpose of this document.

This document will describe step by step how the "run_analysis.R" script works, what kind of transformations were made to create "tidydata.txt" from the raw data. Please see the "CodeBook.md" as well to have better understanding on the content of the "tidydata.txt".


##Step 0/A: get data from website (manually).

Please download and unzip manually the data into your working directory for the project from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Step 0/B: load data into R.

Load the relevant .txt data from working directory into R (no header!):

```{r}
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
```

##Step 1: Merges the training and the test sets to create one data set.

Name the variables using features data (both train/test):

```{r}
names(xtrain) <- features$V2
names(xtest) <- features$V2
```

Fit the activity info (both train/test):

```{r}
names(ytrain) <- c("ActivityCode")
trainmerge <- cbind(ytrain, xtrain)

names(ytest) <- c("ActivityCode")
testmerge <- cbind(ytest, xtest)
```

Fit the subject info (both train/test):

```{r}
names(subjecttrain) <- c("SubjectCode")
trainmerge <- cbind(subjecttrain, trainmerge)

names(subjecttest) <- c("SubjectCode")
testmerge <- cbind(subjecttest, testmerge)
```

Merge the complete train and test datasets:
```{r}
fulldata <- rbind(trainmerge, testmerge)
```

##Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Select variables based on their name containing "mean()" term exactly (fixed = TRUE):

```{r}
meanset <- fulldata[grep("mean()", names(fulldata), fixed = TRUE)]
```

Select variables based on their name containing "std()" term exactly (fixed = TRUE):

```{r}
stdset <- fulldata[grep("std()", names(fulldata), fixed = TRUE)]
```

Select variables with subject / activity data:

```{r}
subact <- fulldata[1:2]
```

Create the requested extraction:

```{r}
mean_std_set <- cbind(subact, meanset, stdset)
```

##Step 3: Uses descriptive activity names to name the activities in the data set.

Rename and merge activity names using activities dataframe based on activity_labels.txt (sorting not needed, sort = FALSE): 

```{r}
names(activities) <- c("ActivityCode", "ActivityName")
mean_std_set <- merge(mean_std_set, 
                      activities, 
                      by.x="ActivityCode",
                      by.y="ActivityCode",
                      all = TRUE, 
                      sort = FALSE)
```

Shape the result:

```{r}
actlab <- mean_std_set[69]
subjlab <- mean_std_set[2]
measuredata <- mean_std_set[3:68]
mean_std_lab_set <- cbind(subjlab, actlab, measuredata)
```

##Step 4: Appropriately labels the data set with descriptive variable names. 

Done at "Step 1" to avoid any problems due to data processing (e.g. reodering the data or something like that). Please see the "CodeBook.md" regarding the applied variable naming rules.


##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Calculate average of each variable by subject and activity:

```{r}
tidydata <- aggregate(mean_std_lab_set[, 3:68], 
                      list(SubjectCode = mean_std_lab_set$SubjectCode, 
                           ActivityName = mean_std_lab_set$ActivityName),
                      mean)
```

Reorder the results by subject and activity:

```{r}
library(plyr)
tidydata <- arrange(tidydata, SubjectCode, ActivityName)
```

Modify the variable names to indicate the content (average values):

```{r}
nameold <- names(tidydata)
namenew <- c(nameold[1:2], sub("(?<=.{0})", "Avg_", nameold[3:68], perl=TRUE))
names(tidydata) <- namenew
```

Write results into text file, as it was requested (row.name=FALSE):

```{r}
write.table(tidydata, file = "tidydata.txt", row.name = FALSE)
```

##Done! :)

