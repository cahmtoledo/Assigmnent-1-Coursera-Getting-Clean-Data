# GettingCleanDataAssigment

## Analysis steps:
1) The **subjects Ids** were extracted from *subject_train.txt* and *subject_test.txt*

2) The **activities labels** were extracted from *y_train.txt* and *y_test.txt* and where matched with the **activity** name using *labels.txt* as reference

3) The subjects were labeled with either **train** or **test**

4) the **train features** were extracted from X_train.txt and

5) it was filtered to features whose name have the word “mean”, “Mean”, “std” or “Std” in middle

6) the same process were made to **test features**

7) the train data frame and the test data frames were made and merged

8) a tidy data frame were obtained by obtaining the mean of each feature to each combination of **Id** and **Activity**

9) the data frames were converted into csv and uploaded to github together with the scripts used
