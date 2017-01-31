#Mikko Järvi 30.1.2017. This is a R script file for week 2 exercise.

#reading the learning data from internet
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE )

#exploring dimension of the data dim() = rows, columns 
dim(learning2014)

#structure of the data
str(learning2014)



