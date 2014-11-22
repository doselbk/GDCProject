# Code

data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


# Check for the required packages
# - if not found, install the packages

# Load the required packages

# Set the current directory as the working directory
this.dir <- dirname(parent.frame(2)$ofile)
cat("setting", this.dir, "as the working directory\n")
setwd(this.dir)

# Check for the data file
# - if not found, download the data and unzip the data file in the data folder under the working directory

data.dir <- paste(this.dir, "data", sep = "/", collapse = "/")
data.file <- paste(data.dir, "UCIHARDataset.zip", sep = "/", collapse = "/")

## Check the data folder under the working directory
cat("checking for the data folder\n")
if (!file.exists(data.dir)) {
  cat("- creating", data.dir, "to save the data\n")
  dir.create(file.path(data.dir))
} else {
  cat("- found it\n")
}

## Check the data file is in the data directory
cat("checking for the data file in the data directory\n")
if (!file.exists(data.file)) {
  cat("- downloading the data from", data.url, "to", data.dir, "\n")
  download.file(data.url, data.file, method = "curl")
  cat("- unzipping the data files to", data.dir, "\n")
  unzip(data.file, exdir = data.dir)
} else {
  cat("- found", data.file, "\n")
}

data.unzipped.dir <- paste(data.dir, "UCI HAR Dataset", sep = "/", collapse = "/")

# At this point, the data files should be in /data/UCI HAR Dataset/
# 
# Data to load:
# /activity_labels.txt | complete list of activities
# /features.txt | complete list of features

# /test/subject_test.txt | subject list 
# /test/y_test.txt | activity list
# /test/X_test.txt | test data file

# /train/subject_train.txt | subject list
# /train/y_train | activity list
# /train/X_train | train data file

activity.label <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE)
features.label <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE)

#features = read.table('./features.txt',header=FALSE); #imports features.txt
#activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
#subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
#xTrain = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
#yTrain = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
# Assigin column names to the data imported above
#colnames(activityType) = c('activityId','activityType');
#colnames(subjectTrain) = "subjectId";
#colnames(xTrain) = features[,2];
#colnames(yTrain) = "activityId";
# cCreate the final training set by merging yTrain, subjectTrain, and xTrain
#trainingData = cbind(yTrain,subjectTrain,xTrain);
# Read in the test data
#subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
#xTest = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
#yTest = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
