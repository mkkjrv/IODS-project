#Mikko Järvi 10.2.2017. This is a script file for the week 3 exercise.

#tools
library(dplyr)

#reading the data from csv files
math <- read.csv("~/mikko/IODS-project/data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("~/mikko/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

#exploring the data of both files
dim(math)
dim(por)

structure(math)
structure(por)

#joining the two files with common columns as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#joining the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

#checking the result
colnames(math_por)
