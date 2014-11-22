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
if (!file.exists(data.dir)) {
  cat("creating", data.dir, "to save the data\n")
  dir.create(file.path(data.dir))
}

## Check the data file is in the data directory
if (!file.exists(data.file)) {
  cat("downloading the data from", data.url, "to", data.dir, "\n")
  download.file(data.url, data.file, method = "curl")
  cat("unzipping the data files\n")
  unzip(data.file, exdir = data.dir)
}
  
