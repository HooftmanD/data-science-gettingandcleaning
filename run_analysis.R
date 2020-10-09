## Merging training and test data set
library(dplyr)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityLabels", "activityName"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureLabels", "featureName"))

getSet <- function(t, l, f) {
  subjects <- read.table(paste0("./UCI HAR Dataset/", t, "/subject_", t, ".txt"), col.names = c("subjectId"))
  X <- read.table(paste0("./UCI HAR Dataset/", t, "/X_", t,".txt"))
  Y <- read.table(paste0("./UCI HAR Dataset/", t, "/y_", t,".txt"))
  
  colnames(X) <- features$featureName
  colnames(Y) <- c("activityLabels")
  
  data <- cbind(subjects, X, Y)
}

data <- rbind(getSet("train", labels, features), getSet("test", labels, features))

meanAndSD <-
  data[, c(1, grep(pattern = "mean\\(\\)|std\\(\\)", x = names(data)), 563)] %>% # Getting only columns with mean and standard deviation
  mutate(activity = factor(activityLabels, levels = labels$activityLabels, labels = labels$activityName)) %>% # Use descriptive activity names in the dataset
  select(meanAndSD, subjectId, activity, everything(), -activityLabels)

# Appropriately label data set
colnames(meanAndSD) <- gsub(pattern = "\\(\\)", replacement = "", x = names(meanAndSD))

# Get average of each variabe activity and subject
meanAndSDAverage <- meanAndSD %>% group_by(subjectId, activity) %>% summarise_all(funs(mean))

write.table(meanAndSD, file = 'tidyData.txt', row.names = FALSE)
write.table(meanAndSDAverage, file = 'tidyDataAverage.txt', row.names = FALSE)