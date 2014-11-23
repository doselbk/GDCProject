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

activity.label <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names = c("ID", "Activity"))
features.label <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE, col.names = c("ID", "Feature"))

subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names = c("Subject.ID"))
activity.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = c("Activity.ID"))
data.test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names = features.label$Feature)

subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names = ("Subject.ID"))
activity.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = c("Activity.ID"))
data.train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names = features.label$Feature)

