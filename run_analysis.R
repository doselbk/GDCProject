# Code

packages.check <- function(require.packages) {
# PARAMETER: take a list of package names 
# check required packages from installed.packages() 
# - if found, load the package
# - if not found, install and load the package
  for (i in require.packages)
    if (i %in% rownames(installed.packages()) == TRUE) {
      library(i, character.only = TRUE)
    } else {
      install.packages(i, character.only = TRUE)
      library(i, character.only = TRUE)
    }
}

# Check for the required packages
# - if not found, install the missing package
# - load the required packages

require.packages <- c("plyr", "reshape2")
packages.check(require.packages)



# the data file source
data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

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
  cat("- found", data.dir, "\n")
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

# At this point, the data files should be in ./data/UCI HAR Dataset/
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

activity.label <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names = c("ActivityID", "ActivityType"))
features.label <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE, col.names = c("ID", "Feature"))

cat("building the test data\n")
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names = c("Subject"))
activity.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = c("ActivityID"))
activity.test <- join(activity.test, activity.label, by="ActivityID")
data.test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names = features.label$Feature)
data.test <- cbind(subject.test, activity.test, data.test)
data.test <- mutate(data.test, datasource = "Test")
cat("done building the test data\n")

cat("building the train data\n")
subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names = ("Subject"))
activity.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = c("ActivityID"))
activity.train <- join(activity.train, activity.label, by="ActivityID")
data.train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names = features.label$Feature)
data.train <- cbind(subject.train, activity.train, data.train)
data.train <- mutate(data.train, datasource = "Train")
cat("done building the train data\n")

cat("merge the test and train data into one\n")
dt <- rbind(data.test, data.train)
cat("done merging\n")
