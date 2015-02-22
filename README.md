# CourseProject
## Getting and Cleaning Data Course Project
### Distill the Samsung Galaxy S Smartphone accelerometer data to averages per subject activity

This script takes the UCI Samsung Galaxy S Smartphone accelerometer test data provided from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and distills it down to averages for each test subject while performing various activities. The data are manipulated as follows:

1. The x training and test data are combined.
  + Only the data columns whose labels contain 'mean' and 'std' are retained
2. The y (activity) training and test data are combined.
  + The y values are converted to text using the labels
3. The subject training and test data are combined.
4. The previously calculated x data (step 1) are aggregated by mean for each subject activity

The resulting generated data can be viewed by executing:
```
data <- read.table("output.file.txt", header=T)  
View(data)
```
