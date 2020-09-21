library(data.table)
library(dplyr)
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
sub_test<-read.table("subject_test.txt")
 View(sub_test)
 x_test<-read.table("X_test.txt")
 y_test<-read.table("y_test.txt")
 setwd("C:/Users/Tian/Documents/R/clean-data/UCI HAR Dataset/train")
 x_train<-read.table("X_train.txt")
 y_train<-read.table("y_train.txt")
 sub_train<-read.table("subject_train.txt")
 merge_x<-rbind(x_test,x_train)
 merge_y<-rbind(y_test,y_train)
 merge_sub<-rbind(sub_test,sub_train)
 setwd("C:/Users/Tian/Documents/R/clean-data/UCI HAR Dataset")
 ft<-read.table("features.txt",stringsAsFactors = FALSE)
 merge_all<-cbind(merge_x,merge_y,merge_sub)
mean_index<-grep(("mean\\(\\)|std\\(\\)"),ft)
  