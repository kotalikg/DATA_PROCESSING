---
title: "CodeBook.md"
output: html_document
---

##Purpose of this document. 

This document will describe the content of the "tidydata.txt", including information on the created variables in the file ("Code Book") and some background information on how data was collected ("Study design").


##Code book

The naming rules of variables somehow should balance between human readibility and general usability. In this case, to avoid extra long variable names, I basically kept the original variable names of the processed dataset which is available from here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of variables in "tidydata.txt":

- SubjectCode variable referrs to the 30 volunteers who collected the data (1-30).
- ActivityName variable shows the performed six activities by volunteers:
      * WALKING, 
      * WALKING_UPSTAIRS, 
      * WALKING_DOWNSTAIRS, 
      * SITTING, 
      * STANDING, 
      * LAYING.
- Measurement variables (column 3 - 68):
      * Values: average (Note: "Avg_") normalized [within -1,1] mean ("mean()" variables) or standard deviation ("std()" variables) for each volunteers (SubjectCode) and each activities (ActivityName). Important: the downloaded data was normalized, and normalization "eliminated" the units of original distance measurements!  
      * "t": time domain signals / "f": frequency domain signals.
      * "Body": body acceleration signals / "Gravity": gravity acceleration signals.
      * "ACC": accelerometer signals / "Gyro": gyroscope signals.
      * "Jerk": body linear acceleration and angular velocity (Jerk signals).
      * "Mag": calculated magnitude using Euclidean norm.
      * "X/Y/Z": 3-axial signals in the X, Y and Z directions.
            
Measurement variable explanation example ("Avg_tBodyAcc-mean()-X", column 3):

- "Avg_": average value (NA removed by default in calculation) calculated for given volunteer and given activity,
- "t": time domain signal,
- "Body": body acceleration signal,
- "Acc" : accelerometer signal,
- "mean()" : calculated mean value, normalized [within -1,1],
- "X" : for X-axial signal.

Other measurement variables have the same logic contentwise.

For more information about the original dataset contact: activityrecognition@smartlab.ws

##Study design (background of the data)

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain." 

(source: README.txt in the downloaded zip file)

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

(source: features_info.txt in the downloaded zip file)





