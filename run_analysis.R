##Setting packages
library(dplyr)
library(reshape2)

##Getting datasets (test)
setwd("./UCI HAR Dataset/test")
Test_Subject<-read.table("subject_test.txt", colClasses = "numeric")
Test_X<-read.table("X_test.txt", colClasses = "numeric")
Test_Y<-read.table("y_test.txt", colClasses = "numeric")
setwd("..")

##Getting datasets (train)
setwd("./train")
Train_Subject<-read.table("subject_train.txt", colClasses = "numeric")
Train_X<-read.table("X_train.txt", colClasses = "numeric")
Train_Y<-read.table("y_train.txt", colClasses = "numeric")
setwd("..")

## 1. Merging DataSets into one DataSet
## Combining Test tables into one
Test<-cbind(Test_Subject,Test_Y,Test_X)
## Combining Train tables into one
Train<-cbind(Train_Subject, Train_Y, Train_X)
## Combining both DataSets
DFrame<-rbind(Test,Train)

## 2. Extracting measurements on the mean and standard deviation for each measurement. 
## Renaming variables 
Features<-read.table("features.txt",colClasses = "character")
names(DFrame)<-c("subject","action",Features[,2])
## Selecting columns: subject, activities, means and standard deviations
means<-grep("mean\\(\\)",names(DFrame),value=T)
stds<-grep("std\\(\\)",names(DFrame),value=T)
DFrame<-DFrame[,c("subject", "action", means,stds)]

## 3. Use descriptive activity names to name the activities in the data set
## Arranging measurements
DFrame<-arrange(DFrame, subject, action)
## Getting mapping table for activities
ALabels<-read.table("activity_labels.txt")
names(ALabels)[2]<-"activity"
##Merging activities according to the code provided in the original dataset
DFrame_aux<-merge(DFrame,ALabels,by.x="action",by.y="V1")
##Getting code variable erased
DFrame<-select(DFrame_aux,-action)
variables<-names(DFrame[2:67])
DFrame<-melt(DFrame,measure.vars=variables)

## 4. Labeling the data set with descriptive variable names and rearragning it
names(DFrame)<-c("subject","activity","feature","result")

## 5. Creating a different DataSet with averaging each variable grouped by activity and subject
DFrame2<-group_by(DFrame,subject,activity,feature)
DFrame3<-summarize(DFrame2,result=mean(result))

## Exporting results in a file
setwd("..")
write.table(DFrame3,"tidy.txt",row.names=F)
