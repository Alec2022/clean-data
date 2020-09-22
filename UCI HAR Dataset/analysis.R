library(data.table)
library(dplyr)

#Load data
setwd("/Users/lyyyon/Documents/R/W3/UCI HAR Dataset/test")
sub_test<-read.table("subject_test.txt")
View(sub_test)
x_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
setwd("/Users/lyyyon/Documents/R/W3/UCI HAR Dataset/train")
x_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
sub_train<-read.table("subject_train.txt")

#Merge data
merge_x<-rbind(x_test,x_train)
merge_y<-rbind(y_test,y_train)
merge_sub<-rbind(sub_test,sub_train)
setwd("/Users/lyyyon/Documents/R/W3/UCI HAR Dataset")
ft<-read.table("features.txt",stringsAsFactors = FALSE)
merge_all<-cbind(merge_x,merge_y,merge_sub)

#Extract mean and std measurements
meanstd_index<-grep("[mean]|[std]", ft)
data.sub <- merge_all[,c(1,2,meanstd_index + 2)]

#Name activities
setwd("/Users/lyyyon/Documents/R/W3/UCI HAR Dataset")
act.labels <- read.table('activity_labels.txt')
act.labels <- as.character(act.labels[,2])
data.sub$activity <- act.labels[data.sub$activity]

#Label data sets
names.new<-names(data.sub)
names.new <- gsub("[(][)]", "", names.new)
names.new <- gsub("^t", "TimeDomain_", names.new)
names.new <- gsub("^f", "FrequencyDomain_", names.new)
names.new <- gsub("Acc", "Accelerometer", names.new)
names.new <- gsub("Gyro", "Gyroscope", names.new)
names.new <- gsub("Mag", "Magnitude", names.new)
names.new <- gsub("-mean-", "_Mean_", names.new)
names.new <- gsub("-std-", "_StandardDeviation_", names.new)
names.new <- gsub("-", "_", names.new)
names(data.sub) <- names.new

#Create tidy data
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)