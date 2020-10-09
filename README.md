# data-science-gettingandcleaning
The code has five fases as requested by the assignment. Before importing the data the library dplyr is imported which will be used for part of the data manipulation.

1. Merges the training and the test sets to create one data set.
This was done by importing the two datasets and adding column names to them. Then rbind() was used to merge the tho tables.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
Only the columns containing mean() or std() are kept by using grep() in combination with a regular expression pattern.

3. Uses descriptive activity names to name the activities in the data set
Mutate the data so a new column is created based on the activity names beloning to the activity labels.

4. Appropriately labels the data set with descriptive variable names.
Remove the parentheses from the column names of the data set.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Group a second dataset based on the first dataset by subjectId and activity and get the mean of all variables with summarise_all

Save the two data sets to disk.