#Mikko Järvi 17.2.2017. This is a R script file for week 5 exercise.

#install.packages("dplyr")
install.packages("plotly")
#library(dplyr)

#reading the data from internet
#http://hdr.undp.org/en/content/human-development-index-hdi
#http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
dim(hd)
summary(hd)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
dim(gii)
summary(gii)

#cleaning hd
colnames(hd)
colnames(hd)[1] <- "hdi_rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi_index"
colnames(hd)[4] <- "life_exp"
colnames(hd)[5] <- "edu_years"
colnames(hd)[6] <- "edu_mean"
colnames(hd)[7] <- "gni_capita"
colnames(hd)[8] <- "gni_rank"
colnames(hd)