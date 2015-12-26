## Getting and Cleaning Data Project

Siddhesh Tiwari

### Description
Code book describes the variables, the data, and any transformations or work that you performed to clean up the data

### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Section 1. Merge the training and the test sets to create one data set.
# 1. Read Following Data files in R
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt
# 2. Merge the data sets seperately
- Merge using rbind() x_train,y_train,subject_train with x_test,y_test,subject_test respectively.
# 3. Assign Proper Column Names and Final Merge
- Use features.txt to extraxt the column names and assign proper column names to merged data sets.
- Finally merge all three data sets using cbind().


## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
- Create a variable which contains column index of only those column which contains mean or std in their name using grep() and regex.
- Use this variable to subset data from final merged data set.

## Section 3. Use descriptive activity names to name the activities in the data set
- Read activity file which contains label names for activity.
- Provide value in activity column based on label names provided in activity file

## Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
- Produce a data set with the average of each variable which are grouped by subject and activity using aggregate() in plyr package.