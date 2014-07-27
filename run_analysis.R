# Package dependencies
if (!require("data.table")) {
    install.packages("data.table") 
    require("data.table")
}
if (!require("reshape2")) {
    install.packages("reshape2")
    require("reshape2")
}

# read in all relevant files
subject_test <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt", quote="\"")
subject_train <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt", quote="\"")
features <- read.table("./UCI\ HAR\ Dataset/features.txt", quote="\"")
activity_labels <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt", quote="\"")

# Get feature and activity titles
feature_titles <- features[,2]
activity_titles <- activity_labels[,2]

# set x test and train names to feature titles
names(X_test) <- feature_titles
names(X_train) <- feature_titles

# strip out all fields that are not mean or standard deviation
X_test <- X_test[,grepl("mean|std", feature_titles)]
X_train <- X_train[,grepl("mean|std", feature_titles)]

# combine X test and training rows
features_data <- rbind(X_test, X_train)

# add a second column of activity titles based on the activity id
y_test[,2]  <- activity_titles[y_test[,1]]
y_train[,2] <- activity_titles[y_train[,1]]

# combine Y test and training rows
activities<-rbind(y_test, y_train)

# set activity names
names(activities)<-c("activity_id", "activity_title")

# combine subject test and train ids
subjects <- rbind(subject_test, subject_train)
names(subjects) <- 'subject_id'

# combine subjects, activities and features into one data table
combined_data <- cbind(as.data.table(subjects), activities, features_data)

# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject
data_melt <- melt(combined_data, id = c("subject_id", "activity_id", "activity_title"), measure.vars = names(features_data))
tidy_data <- dcast(data_melt, subject_id + activity_title ~ variable, mean)

# Output tidy_data to a file.
write.table(tidy_data, file="tidy_data.txt")



