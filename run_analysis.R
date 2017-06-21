library(dplyr)
require(data.table)

labels_key <- read.table("activity_labels.txt")
setnames(labels_key, c("activity_id", "activity_name"))

headings <- read.table("features.txt")

# Grab only the mean and standard deviation columns
required_columns <- filter(headings, grepl("-mean\\(|std\\(", V2))
setnames(required_columns, c("column", "label"))


# Clean the test values
test_values <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
test_subjects <- read.table("test/subject_test.txt")

setnames(test_labels, c("activity_id"))
setnames(test_subjects, c("subject_id"))

test_mean_and_std_values <- test_values[,required_columns$column]
setnames(test_mean_and_std_values, as.character(required_columns$label)) 

test_merged <- merge(test_mean_and_std_values, test_labels, by="row.names")
test_merged <- cbind(test_merged, test_subjects)
cleaned_test_values <- subset(mutate(left_join(test_merged, labels_key), set="test"), select = -Row.names)

# Clean the train values 
train_values <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
train_subjects <- read.table("train/subject_train.txt")
setnames(train_labels, c("activity_id"))
setnames(train_subjects, c("subject_id"))

train_mean_and_std_values <- train_values[,required_columns$column]
setnames(train_mean_and_std_values, as.character(required_columns$label)) 

train_merged <- merge(train_mean_and_std_values, train_labels, by="row.names")
train_merged <- cbind(train_merged, train_subjects)
cleaned_train_values <- subset(mutate(left_join(train_merged, labels_key), set="train"), select= -Row.names)

# And now the magic starts...

all_values <- rbind(cleaned_train_values, cleaned_test_values)

#important: Groups were split 70/30 test/train, respectively. This groups by the set (train or test) 
final_averages <- group_by(all_values, activity_name, activity_id, set, subject_id) %>% summarize_all(funs(mean))
