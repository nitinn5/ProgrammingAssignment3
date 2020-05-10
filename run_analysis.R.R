
# import data, labels and column names
features = read.table("./UCI HAR Dataset/features.txt")
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("y","activity_label"))
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features[,2])
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = 'y')
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = 'subject')
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features[,2])
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = 'y')
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = 'subject')

# merge data
train_labelled <- cbind(subjects_train, y_train, X_train)
test_labelled <- cbind(subjects_test, y_test, X_test)
df <- rbind(train_labelled, test_labelled)
names(df) <- tolower(names(df))

# keep only matching columns
tomatch <- c("mean","std")
df <- df[,c(1, 2, grep(paste(tomatch,collapse="|"),names(df),value = FALSE))]

# add activity labels
df <- merge(x = df,y = activity_labels, by="y",all.x = TRUE)

# move the last column to first
index <- grep("activity_label",names(df))
df <- df[,c(index,(1:ncol(df))[-index])]

# create a summary dataset
library(dplyr)
df_final = aggregate( . ~ activity_label + subject, data=df, sum, na.rm=TRUE)

write.table(df_final, file = "./summarized_data.txt", , sep = "\t", row.names = FALSE, col.names = TRUE)




