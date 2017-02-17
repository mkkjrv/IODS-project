#Mikko Järvi 17.2.2017. This is a R script file for week 5 exercise.

#install.packages("dplyr")
#library(dplyr)

#reading the data from internet
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
summary(hd)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
summary(gii)
