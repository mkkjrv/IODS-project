#Mikko Järvi 17.2.2017. This is a R script file for week 5 exercise.

#packages and libraries
#install.packages("dplyr")
#install.packages("plotly")
#library(dplyr)
#library(stringr)

#reading the data from internet
#http://hdr.undp.org/en/content/human-development-index-hdi
#http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
dim(hd)
summary(hd)
glimpse(hd)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
dim(gii)
summary(gii)
glimpse(gii)

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

#cleaning gii
colnames(gii)
colnames(gii)[1] <- "gii_rank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "gii_index"
colnames(gii)[4] <- "mortality"
colnames(gii)[5] <- "young_mom"
colnames(gii)[6] <- "women_parlament"
colnames(gii)[7] <- "edu_female"
colnames(gii)[8] <- "edu_male"
colnames(gii)[9] <- "labour_female"
colnames(gii)[10] <- "labour_male"
colnames(gii)

#adding two new variables to gii
gii <- mutate(gii, edu_ratio = edu_female / edu_male)
glimpse(gii)

gii <- mutate(gii, labour_ratio = labour_female / labour_male)
glimpse(gii)

#joining the two datasets (hd and gii) 
human <- inner_join(gii, hd, by = "country", suffix = c(".gii", ".hd"))
glimpse(human)
str(human)

#saving data 
write.table(human, file="human.txt")

#reading and checking the file, end of the RStudio exercise 4 
human <- read.table("~/IODS-project/data/human.txt", header = TRUE)
#str(sometable)


#changing the GNI variable to numeric 
str(human)
human <- mutate(human, gni_capita = str_replace(human$gni_capita, pattern=",", replace ="") %>% as.numeric())
str(human)

#removing unneeded variables
keep <- c("country", "gni_capita", "life_exp", "edu_years", "mortality", "young_mom", "women_parlament", "edu_ratio", "labour_ratio")
human <- dplyr::select(human, one_of(keep))


#removing all the rows with missing values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))
str(human)

#removing rows which relate to regions
human$country
last <- nrow(human) - 7
human <- human[1:last, ]
str(human)

#row names
rownames(human) <- human$country
human <- dplyr::select(human, -country)

#check working directory and save the human.txt to the data folder
getwd()
write.table(human, file="human.txt")

#sometable <- read.table("~/IODS-project/data/human.txt", header = TRUE)
#str(sometable)
