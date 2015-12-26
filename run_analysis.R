#Step 1:Merges the training and the test sets to create one data set.
#Read Training and Test Data Set
subject_train <- read.table("./GNCD/train/subject_train.txt",header = FALSE)
X_train <- read.table("./GNCD/train/x_train.txt",header = FALSE)
Y_train <- read.table("./GNCD/train/y_train.txt",header = FALSE)

subject_test <- read.table("./GNCD/test/subject_test.txt",header = FALSE)
X_test <- read.table("./GNCD/test/x_test.txt",header = FALSE)
Y_test <- read.table("./GNCD/test/y_test.txt",header = FALSE)

#Merge Seperate Data Sets
subject_full <- rbind(subject_train,subject_test)
X_full <- rbind(X_test,X_train)
Y_full <- rbind(Y_test,Y_train)

#Read Features of X 
features <- read.table("./GNCD/features.txt",header = FALSE)

#Give Appropiate Column Names to Data Set
names(subject_full) <- c("Subject")
names(Y_full) <- c("Activity")
names(X_full) <- features[,2]

#Make Final data set from the 3 separate sets
Final_data <- cbind(X_full,Y_full,subject_full)

#Step2 :Extracts only the measurements on the mean and standard deviation for
##each measurement. 
#Find the Features for Mean and Standard deviation
mean_std <- grep("mean\\(\\)|std\\(\\)",features[,2])
mean_std
#Subset data for Only Mean and Standard Deviation Columns
Final_data <- subset(Final_data,select = c(mean_std,562,563))

##subdataFeaturesNames<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
##subdataFeaturesNames
##selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
##Data<-subset(Data,select=selectedNames)

#Step 3: Uses descriptive activity names to name the activities in the data set
##Assign Activity Labels to Y data set values
activityLabels <- read.table("./GNCD/activity_labels.txt",header = FALSE)
Final_data$Activity <- activityLabels[Final_data$Activity,2]

#Step 4: Appropriately labels the data set with descriptive variable names.
#Appropiately provide descriptive variable names
names(Final_data)<-gsub("^t", "time", names(Final_data))
names(Final_data)<-gsub("^f", "frequency", names(Final_data))
names(Final_data)<-gsub("Acc", "Accelerometer", names(Final_data))
names(Final_data)<-gsub("Gyro", "Gyroscope", names(Final_data))
names(Final_data)<-gsub("Mag", "Magnitude", names(Final_data))
names(Final_data)<-gsub("BodyBody", "Body", names(Final_data))
names(Final_data)<-gsub("\\()","", names(Final_data))
names(Final_data)<-gsub("-std$","StdDev", names(Final_data))
names(Final_data)<-gsub("-mean","Mean", names(Final_data))
names(Final_data)<-gsub("([Gg]ravity)","Gravity", names(Final_data))


#Step 5: From the data set in step 4, creates a second, independent tidy data set
##with the average of each variable for each activity and each subject.
library(plyr)
avg_data <- aggregate(Final_data[,1:66],by=list(Final_data$Subject,Final_data$Activity),mean)
names(avg_data)[1] <- c("Subject")
names(avg_data)[2] <- c("Activity")

##Data2<-aggregate(. ~Subject + Activity,Final_data, mean)
##Data2<-Data2[order(Final_data$subject,Final_data$activity),]
write.table(avg_data, file = "tidydata.txt",row.name=FALSE)


