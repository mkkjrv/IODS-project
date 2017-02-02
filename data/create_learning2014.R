#Mikko Järvi 30.1.2017. This is a R script file for week 2 exercise.

#install.packages("dplyr")
#library(dplyr)

#reading the learning data from internet
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE )

#exploring dimension of the data with dim(), output = rows, columns 
dim(learning2014)

#structure of the data
#data includes 183 observations and 60 variables, most of variables are integers
str(learning2014)

#questions related to deep, surface and strategic learning according to the datacamp exercise
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#select the columns related to the component in hand and creating columns by averaging  
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

startegic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(startegic_columns)

#choose relevant columns to keep
keep_col <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

#create a new dataset from 'keep_col'
learning2014 <- select(learning2014, one_of(keep_col))

#check the new dataset learning2014
str(learning2014)

#cleaning
colnames(learning2014)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"
colnames(learning2014)

#select rows where points is >0
learning2014 <- filter(learning2014, points > 0)

#final check
str(learning2014)

#save the dataset to data folder
write.table(learning2014, file="learning2014.txt")

#read and check the file
sometable <- read.table("~/IODS-project/data/learning2014.txt", header = TRUE)
str(sometable)
