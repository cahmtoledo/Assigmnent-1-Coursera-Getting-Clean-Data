library(dplyr)

#This will atribute each label to each activity
labelAtrib <- function(x){
    label <- if(x==1){
        "WALKING"
    }
    else if(x==2){
        "WALKING_UPSTAIRS"
    }
    else if (x==3){
        "WALKING_DOWNSTAIRS"
    }
    else if (x==4){
        "SITTING"
    }
    else if(x==5){
        "STANDING"
    }
    else if(x==6){
        "LAYING"
    }
    else{
        errorCondition("Label Not Found!!")
    }
}


#This reads the subject Id and saves in a data.frame
train <- read.delim("UCI HAR Dataset/train/subject_train.txt",sep = '\n', col.names = "Id", header = F)
test <- read.delim("UCI HAR Dataset/test/subject_test.txt", sep='\n', col.names = "Id", header = F)

#This reads the activity label and saves in a data.frame and
#after it creates a list with the name of the activity associated
trainingLabels <- read.delim("UCI HAR Dataset/train/y_train.txt", sep='\n', header = F, col.names = "activityLabels")
trainingPos <- sapply(trainingLabels$activityLabels, labelAtrib)

testingLabels <- read.delim("UCI HAR Dataset/test/y_test.txt", sep='\n', header = F, col.names = "activityLabels")
testingPos <- sapply(testingLabels$activityLabels, labelAtrib)


#Here will create a list used in the category Type where we see
#if the subject is from train set or test set
testLabel <- rep("test", 2947)
trainLabel <- rep("train", 7352)


#Creating train features df
trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)
FeaturesNames <- read.table("UCI HAR Dataset/features.txt")[,2]
names(trainFeatures) <- FeaturesNames
trainFeatures <- trainFeatures[,grep("*[Mm]ean*|*[Ss]td*", FeaturesNames)]

#Creates train df
dftrain <- data.frame(train)
dftrain$Type <- trainLabel
dftrain$Activity <- trainingPos
dftrain <- cbind(dftrain, trainFeatures)

#Creating test features df
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)
names(testFeatures) <- FeaturesNames
testFeatures <- testFeatures[,grep("*[Mm]ean*|*[Ss]td*", FeaturesNames)]


#Creates test df
dftest <- data.frame(test)
dftest$Type <- testLabel
dftest$Activity <- testingPos
dftest <- cbind(dftest, testFeatures)

#concatenate them
df <- rbind(dftrain, dftest)

#Lets group by activityLabel and Id

tidy <- df %>% group_by(Id,Type, Activity) %>% summarise_each(funs(mean))

write.csv(tidy, "tidy.csv", row.names = F)
write.csv(df, "Table.csv", row.names = F)

write.table(tidy, "tidy.txt", row.names = F)
