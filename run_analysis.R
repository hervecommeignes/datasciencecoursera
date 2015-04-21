setwd("./documents/datascience/r/getting_and_cleaning_data")

#1 Merges the training and the test sets to create one data set.

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_test
x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
head(x_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_trainy_to
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
head(x_train)

y_total <- rbind(y_test, y_train)
y_total
x_total <- rbind(x_test, x_train)
head(x_total)
dim(x_total)


#4. Appropriately labels the data set with descriptive variable names. 

features <- read.table("UCI HAR Dataset/features.txt")
features
features[,2]
colnames(x_total) <- features[,2]
head(x_total)


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

means <- colMeans(x_total)
means

stdevs <- sapply(x_total, sd)
stdevs


#3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities
labels <- activities[,2]
labels

# http://www.cookbook-r.com/Manipulating_data/Renaming_levels_of_a_factor/
y <- y_total[,1]
y
levels(y) <- labels
table(y)

#5. average per subject: where is the subject identifier in the data? it ia in files subject_train.txt
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
head(subject_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
head(subject_train)
subject_total <- rbind(subject_test, subject_train)
head(subject_total)
unique(subject_total)

x <- cbind(subject_total, x_total)
head(x)
colnames(x)[1] <- "subject"
colnames(x)

#averages_per_subject <- tapply(x[,2], x$subject, FUN=mean)
# http://stackoverflow.com/questions/1660124/how-to-group-columns-by-sum-in-r
# http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega?rq=1
averages_per_subject <- aggregate(x, by=list(subject=x$subject), mean)
averages_per_subject[1:10,1:5]
averages_subject <- averages_per_subject[,3:563]
rownames(averages_subject) <- seq(1,30)
averages_subject[,1:5]
length(averages_subject)

#5. average for each avtivity: group by based on y levels
xy <- cbind(y, x_total)
xy[1:10,1:5]
colnames(xy)[1] <- "activity"
colnames(xy)

averages_per_activity <- aggregate(xy, by=list(activity=xy$activity), mean)
averages_per_activity[,1:5]
averages_activity <- averages_per_activity[,3:563]
rownames(averages_activity) <- labels
averages_activity[,1:5]
length(averages_activity)

# combine into one table & write output

averages <- rbind(averages_subject, averages_activity)
head(averages)

?write.table
write.table(averages, file = "averages.txt", row.names = FALSE)
