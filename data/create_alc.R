#Mikko Järvi 10.2.2017. This is a script file for the week 3 exercise.

#tools if needed
#install.packages("tidyverse")
#library(dplyr)
#library(ggplot2)

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
glimpse(math_por)

#create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#glimpse at the new combined data
glimpse(alc)

#creating new columns about alcohol consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# a bar plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))
g1 + geom_bar()

# a bar plot of high_use by sex
g2 <- ggplot(alc, aes(high_use))
g2 + facet_wrap("sex") + geom_bar()

#final check that new columns, variable and observations are in order
glimpse(alc)

#save the dataset to data folder
write.table(alc, file="student_alc.txt")

#read and check the file
sometable <- read.table("~/IODS-project/data/student_alc.txt", header = TRUE)
glimpse(sometable)
