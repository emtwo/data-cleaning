runAnalysis <- function() {
  #################################################################
  ## Part 1: Gathering data
  ################################################################# 
  # 1) Merge the training and the test sets to create one data set.
  train_dataset <- read.table("dataset/train/X_train.txt");
  test_dataset <- read.table("dataset/test/X_test.txt");
  train_labels <- read.table("dataset/train/y_train.txt");
  test_labels <- read.table("dataset/test/y_test.txt");
  train_subject <- read.table("dataset/train/subject_train.txt");
  test_subject <- read.table("dataset/test/subject_test.txt");
  mergedX <- rbind(train_dataset, test_dataset);
  mergedy <- rbind(train_labels, test_labels);
  merged_subjects <- rbind(train_subject, test_subject);
  
  # 2) Set all the column names for the new dataset.
  features <- read.table("dataset/features.txt", stringsAsFactors = FALSE);
  colnames(mergedX) <- features[,2];
  colnames(mergedy) <- "activities";
  colnames(merged_subjects) <- "subjects";
  
  # 3) Extract all mean and std deviation columns from the dataset.
  meanstd <- mergedX[,grep("-mean\\(\\)|-std\\(\\)", colnames(mergedX))];
  
  #################################################################
  ## Part 2: Creating new dataset
  #################################################################
  
  # 1) Create 2 copies of meanstd, each with an additional right-most
  #    column, one for activities, and one for subjects.
  activityAggregate <- cbind(meanstd, mergedy);
  subjectAggregate <- cbind(meanstd, merged_subjects);
  
  # 2) Use these columns to group by activity and subject and compute mean for each group
  activityAggregate <- aggregate(activityAggregate, by=list(activityAggregate$activities), FUN=mean)[,2:ncol(activityAggregate)];
  subjectAggregate <- aggregate(subjectAggregate, by=list(subjectAggregate$subjects), FUN=mean)[,2:ncol(subjectAggregate)];
  
  # 3) Set row labels for activities based on existing labels text file.
  activity_labels <- read.table("dataset/activity_labels.txt", stringsAsFactors = FALSE);
  rownames(activityAggregate) <- activity_labels$V2;
  
  # 4) Set row labels for subjects by appending 'Subject' to the subject ID
  subject_labels <- character();
  lapply(rownames(subjectAggregate), function(x) subject_labels <<- append(subject_labels,paste("Subject", x)));
  rownames(subjectAggregate) <- subject_labels;
  
  # 5) Group the two aggregate results and update column labels to reflect they are averages.
  results <- rbind(activityAggregate, subjectAggregate);
  newColNames <- character();
  lapply(colnames(results), function(x) newColNames <<- append(newColNames, paste("Average", x)));
  colnames(results) <- newColNames;

  print(results);
}