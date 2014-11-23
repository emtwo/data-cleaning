data-cleaning
=============

The run_analysis.R script contained in this repository is responsible for cleaning the data in the dataset folder.

We are given data captured from an accelerometer and gyroscope of a device that was attached to 30 different subjects who performed 6 different tasks.
We would like to gather all mean and standard deviation information for all signals and find their averages for each type of activity as well as for each subject.

The analysis script performs this task in the following way:
1) Merge X_train.txt and X_test.txt as mergedX
2) Merge y_train.txt and y_test.txt as mergedy
3) Merge subject_train.txt and subject_test.txt as merged_subjects

4) Use the feature labels listed in features.txt to set the initial column names of mergedX.
5) Set the column names for mergedy and merged_subjects as 'activities' and 'subjects' respectively. These will be used later

6) Extract the std() and mean() columns from mergedX into an intermediate variable, meanstd

7) Create two copies of meanstd, add an activity column to the end of one and a subjects column at the end of the other

8) Use these new columns to group by activity and group by subject and compute those aggregate means.

9) Set appropriate row labels based on the groupings by subject and by activity. The activity labels are based on activity_labels.txt and the subject labels are "Subject <subject ID>"

10) Set appropriate column names by appending "Average" to the column names set in step 4

11) Merge the two copies of meanstd generated in step 7 to get the end results.

Steps 1-3 correspond to requirement 1 of the assignment and step 1 of part 1 of the script
Step 4 and 5 correspond to requirement 4 of the assignment and step 2 of part 1 of the script
Step 6 corresponds to requirement 2 of the assignment and step 3 of part 1 of the script
Step 8) corresponds to requirement 5 of the assignment and step 2 of part 2 of the script
Step 9) and 10) correspond to requirement 3 and 4 of the assignment and step 3-5 of part 2 of the script
Step 11) corresponds to requirement 5 of the assignment and step 5 of part 2 of the script
