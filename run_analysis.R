# Read in the activity labels file and return a data frame
# By Reese Anschultz

setwd("C:\\Users\\Reese Anschultz\\Desktop\\RProgramming\\getdata_projectfiles_UCI HAR Dataset")

# Variable values
data.home.directory <- "UCI HAR Dataset"  # Relative to current working directory

activity.labels.txt <- "activity_labels.txt"
features.txt <- "features.txt"

train.folder <- "train"
x.train.txt <- "X_train.txt"
y.train.txt <- "Y_train.txt"
subject.train.txt <- "subject_train.txt"

test.folder <- "test"
x.test.txt <- "X_test.txt"
y.test.txt <- "Y_test.txt"
subject.test.txt <- "subject_test.txt"

output.file.txt <- "output.file.txt"

setwd(data.home.directory)

activity.labels<-read.table(activity.labels.txt,sep=" ",col.names=c('id','activity')) # Read in the activity labels

feature.labels<-make.names(read.table(features.txt,sep=" ",col.names=c('id','feature'))[,"feature"])  # Read in the feature labels

# Read in the x data
read.x.data <- function ( filename, column.names )
{
  read.table(filename,col.names=column.names)
}

get.desired.feature.labels <- function ( features )
{
  # TODO: Could use an apply function to make an arbitrary list of search patterns rather than the fixed two for the assignment
  features[rbind(grep("mean..",features,fixed=TRUE),grep("std..",features,fixed=TRUE))]
}

x.test<-read.x.data(file.path(test.folder,x.test.txt),feature.labels) # Get the test data
x.train<-read.x.data(file.path(train.folder,x.train.txt),feature.labels)  # Get the trial data
x.data<-rbind(x.test,x.train) # Merge the test and trial X data

x.data<-x.data[,get.desired.feature.labels(feature.labels)] # Get only the desired columns from X

# Read in the y (activity) values
read.y.data <- function ( filename )
{
  as.numeric(readLines(filename))
}

y.test<-read.y.data(file.path(test.folder,y.test.txt))  # Get the test Y (activity) data
y.train<-read.y.data(file.path(train.folder,y.train.txt)) # Get the trial Y (activity) data
y.data<-c(y.test,y.train) # Merge the test and trial Y data

y.data<-sapply(y.data,function(n){ activity.labels$activity[activity.labels$id==n] }) # Convert the activity value to a string

# Read in the subject values
read.subject.data <- function ( filename )
{
  as.numeric(readLines(filename))
}
subject.test<-read.subject.data(file.path(test.folder,subject.test.txt))  # Get the test subject data
subject.train<-read.subject.data(file.path(train.folder,subject.train.txt)) # Get the trial subject data
subject.data<-c(subject.test,subject.train) # Merge the test and trial subject data

a<-aggregate(x.data,list(subject=subject.data,activity=y.data),mean)  # Calculate the mean of each x.data variable for all subject activities
write.table(a,output.file.txt,row.name=FALSE)
