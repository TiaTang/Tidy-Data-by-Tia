## Hi, below is my code to create a tidy data file. 

## Load dplyr library
library(dplyr)

##Import the data and unzip the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"temp.zip")
unzip("temp.zip")

##Get the list of the files except for the ones under "Inertial" folder.
files <- list.files("./UCI HAR Dataset", full.names=TRUE, recursive = TRUE)
files <- files[-grep("Inertial",files)]

##Set up a function called "readfile" that can read all the files containing the same string "x" 
##in their filenames and combine them together into one data table
readfile <- function(x) {
  list <- grep(x, files,ignore.case = TRUE)
  y <- data.frame()
  if (length(list)==1) {y <- read.table(files[list]);return(y)}
  for (i in list) {
    y <- rbind(y,read.table(files[i]))
  }
  return(y)
}
## Input x file, y file, features file, subject file and activity file using the
## "readfile" function set as above.
x <- readfile("/x_")
y <- readfile("/y_")
features <- readfile("features.txt")
subject <- readfile("subject")
activity <- readfile("activity")

## Set up database "dat" with data in the x file. 
## Rename the variables in dat with the feature names in features.txt
dat <- tbl_dt(x)
dat <- setNames(dat, as.character(features[,2]))

## Set up a temp object that contains a list including the sequence for all the columns
## in dat that has "mean()" or "std()" in the feature name. Select dat with only these columns
temp <- grep(paste(c("mean()","std()"),collapse="|"), names(dat), ignore.case = TRUE)
dat <- select(dat,temp)

## Now dat only has 86 variables. Creat a column in dat with the data in y and call it "acti".
## create another column in dat with the data in subject and call it "subject"
dat <- mutate(dat, acti=y, subject=subject)

## Rename the activity table's columns to "acti" and "acitivity", and then combine dat with 
## activity by "acti", delet "acti" so we have activity names in the file.
activity <- setNames(activity, c("acti","activity"))
activity <- tbl_dt(activity)
dat <-inner_join(dat,activity, by = "acti")
dat <- select(dat,-acti)

## Create a independent data set called "tidy_data", which includes the means for each column in dat,
## by each subject and by each activity. Arrange the tidy_data so it's more readable.
tidy_data <- dat %>% 
  group_by(subject, activity) %>% 
  summarise_each(funs(mean)) %>% 
  arrange(subject,activity);

## Create a file called "tidy_data.txt" in the working directory.
options(digits = 4)
write.table(tidy_data,"tidy_data.txt", row.names = FALSE)

## Thank you for reading this!
