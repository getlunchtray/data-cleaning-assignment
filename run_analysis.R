library(dplyr)
require(data.table)

labels_key <- read.table("original_data/activity_labels.txt")
setnames(labels_key, c("activity_id", "activity_name"))

headings <- read.table("original_data/features.txt")

# Grab only the mean and standard deviation columns
required_columns <- filter(headings, grepl("-mean\\(|std\\(", V2))
setnames(required_columns, c("column", "label"))


# Clean the test values
test_values <- read.table("original_data/test/X_test.txt")
test_labels <- read.table("original_data/test/y_test.txt")
setnames(test_labels, c("activity_id"))

test_mean_and_std_values <- test_values[,required_columns$column]
setnames(test_mean_and_std_values, as.character(required_columns$label)) 

test_merged <- merge(test_mean_and_std_values, test_labels, by="row.names")
cleaned_test_values <- left_join(test_merged, labels_key)

# Clean the train values 
train_values <- read.table("original_data/train/X_train.txt")
train_labels <- read.table("original_data/train/y_train.txt")
setnames(train_labels, c("activity_id"))

train_mean_and_std_values <- train_values[,required_columns$column]
setnames(train_mean_and_std_values, as.character(required_columns$label)) 

train_merged <- merge(train_mean_and_std_values, train_labels, by="row.names")
cleaned_train_values <- left_join(train_merged, labels_key)
