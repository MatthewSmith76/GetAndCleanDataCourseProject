
##
# This script does the following:
#  1. Merges the training and the test sets to create one data set. 
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set 
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the
#     average of each variable for each activity and each subject.

library("dplyr")
library("data.table")

## Part 1. `Merge' Data & Part 4
# Descriptive variable names are employed on load
featureNames <-read.table("UCI HAR Dataset/features.txt")
featureNames <- as.character.default(featureNames$V2)
featureNames <- gsub("()", "", featureNames, fixed = TRUE)
# Read in and join test data
dtX_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = featureNames)
dtY_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
dtS_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
dt_test  <- cbind(dtS_test, dtY_test, dtX_test)


# Read and join train-ing data
dtX_train <-read.table("UCI HAR Dataset/train/X_train.txt", col.names = featureNames)
dtY_train <-read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
dtS_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
dt_train  <- cbind(dtS_train, dtY_train, dtX_train)

dt <- rbind(dt_test, dt_train)

## Part 2. Only Need Mean & Std vars
dt <- tbl_df(dt)
dt <- select(dt, Activity, Subject, matches("mean|std"))

## Part 3. Uses descriptive activity names
activityNames <-read.table("UCI HAR Dataset/activity_labels.txt")
activityNames <- as.character.default(activityNames$V2)

dt <- mutate(dt, Activity = activityNames[Activity])

## Part 5. Make new tidy data set
# average of each variable for each activity and each subject
grpAct <- group_by(dt, Activity)
grpSub <- group_by(dt, Subject)
#
actDt  <- grpAct %>% summarise_each(funs(mean))
subDt  <- grpSub %>% summarise_each(funs(mean))
#
actObs <- t(paste("Activity", actDt$Activity))
subObs <- t(paste("Subject",  subDt$Subject))

newDt  <- rbind(actDt[, -(1:2)], subDt[, -(1:2)])
newCol <- cbind(actObs, subObs) 
newDt  <- cbind(t(newCol), newDt)
names(newDt)[1] <- "Average Over"
write.table(newDt, file = 'AverageSensorData.txt', row.names = FALSE)
