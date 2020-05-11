###################################################
# code for peer granded project of course 3 in data science specialization
###################################################

###################################################
# import names for all columns using the features file and also find labels for all activities
###################################################
features = read.table("./UCI HAR Dataset/features.txt")
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("y","activity_label"))


###################################################
# Import data from train and test datasets for all of - X, Y, and subject ids.
###################################################
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features[,2])
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = 'y')
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = 'subject')
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features[,2])
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = 'y')
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = 'subject')

###################################################
# merge the data imported first among themselves (all train data together, all test data together
# then append the two datasets together to create one large data file. 
###################################################
train_labelled <- cbind(subjects_train, y_train, X_train)
test_labelled <- cbind(subjects_test, y_test, X_test)
df <- rbind(train_labelled, test_labelled)
names(df) <- tolower(names(df))

###################################################
# Not all columns are needed. Only those that contain 'mean' and 'std' in them. Create a pattern and look for the either of 
# these words in the column names. Discard other columns. 
###################################################
tomatch <- c("mean","std")
df <- df[,c(1, 2, grep(paste(tomatch,collapse="|"),names(df),value = FALSE))]

###################################################
# In order to add activity labels against every activity in the large dataset, I've used a left join with the tiny activity label file. 
###################################################
df <- merge(x = df,y = activity_labels, by="y",all.x = TRUE)

###################################################
# This is done just to bring the activity label field to the left
###################################################
index <- grep("activity_label",names(df))
df <- df[,c(index,(1:ncol(df))[-index])]

###################################################
# Now in order to create a summary dataset there are various options possible such as melt() and data.table() functions. 
# I am importing dplyr package and making use of aggregate to get the task done. 
###################################################
library(dplyr)
df_final = aggregate( . ~ activity_label + subject, data=df, sum, na.rm=TRUE)

###################################################
# finally writing the tidy data set as a tab separated file. 
###################################################
write.table(df_final, file = "./tidy_data.txt", , sep = "\t", row.names = FALSE, col.names = TRUE)




