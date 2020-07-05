## Loading libraries
library(dplyr)
library(data.table)
library(tidyr)

## Downloading and unzipping the data
myURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(myURL,"Data")
unzip("Data",junkpaths = TRUE)

## Reading in the data 
filenames<-list.files(pattern="*.txt",full.names = TRUE)
x_test<-fread(file=filenames[25])
y_test<-fread(file=filenames[27])
x_train<-fread(file=filenames[26])
y_train<-fread(file=filenames[28])
subject_test<-fread(file=filenames[17])
subject_train<-fread(file=filenames[18])
Features<-fread(file=filenames[14])
ActivityLabels<-fread(filenames[1])

## Adding names to the activity labels
colnames(ActivityLabels)<-c("key","Activity")

## Adding the featurenames to the test and train datasets
featurenames<-unlist(lapply(Features[,2],as.character))
colnames(x_test)<-featurenames
colnames(x_train)<-featurenames

## Adding the activities to the test and train datasets
testtaskmeasure<-cbind(y_test,x_test)
colnames(testtaskmeasure)[1]<-"Activity"
traintaskmeasure<-cbind(y_train,x_train)
colnames(traintaskmeasure)[1]<-"Activity"

## Adding more descriptive names for the activities
testtaskmeasure[,1]<-ActivityLabels$Activity[match(unlist(testtaskmeasure[,1]),
                                                   ActivityLabels$key)]
traintaskmeasure[,1]<-ActivityLabels$Activity[match(unlist(traintaskmeasure[,1]),
                                                   ActivityLabels$key)]

## Adding the subject data to the test and train datasets
comptest<-cbind(subject_test,testtaskmeasure)
comptrain<-cbind(subject_train,traintaskmeasure)
colnames(comptest)[1]<-"Subject"
colnames(comptrain)[1]<-"Subject"

## Merging the test and train datasets
CombinedData <- rbind(comptest,comptrain)

## Finding the measurements of mean or standard deviation
meanmeasurements<-grep("mean",names(CombinedData),ignore.case = TRUE)
stdmeasurements<-grep("std",names(CombinedData),ignore.case = TRUE)

## Combining the indices of measurements of interest includeing the subject and 
## activity
MeasurementIndex<-c(1,2,meanmeasurements,stdmeasurements)
MeasurementIndex<-sort(MeasurementIndex)

# Creating the final tidy data set of the initial measurements
Measurements<-CombinedData[,..MeasurementIndex]

# Creating the average measurements for each subject and activity
AverageMeasurements<-Measurements %>%
        group_by(Subject,Activity) %>%
        summarise_all(mean)

write.table(AverageMeasurements,file="AvgMeasurements.txt",row.names = FALSE)
