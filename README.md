# Data Cleaning Final Assignment

### Dependencies

- data.table
- dplyr

### Running the analysis

The original data is already included for the project. The data was obtained from: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (Downloads zip file)

To crunch the data in the R console, run:

`source("run_analysis.R")`

from the the home directory of this repo.

### Analysis 

All column headers are sumarized in the CodeBook.md file. All of these variables can be executed in the R console after running the source file.

`cleaned_test_values`

Merges the test/X_test.txt, test/y_test.txt, activity_labels.txt, features.txt and test/subject_test.txt to create a readable data table. 

`cleaned_train_values`

Merges the train/X_train.txt, train/y_train.txt, activity_labels.txt, features.txt and train/subject_train.txt to create a readable data table. 

`all_values`
Combines the `cleaned_test_values` and `cleaned_train_values` into one data table.

`final_averages`
Averages `all_values` by activity and subject.





