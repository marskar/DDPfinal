## Download data file

fileURL<- "http://www.journalofaccountancy.com/content/dam/jofa/issues/2017/jan/general-ledger-collins.xlsx"
destfile <- "./data.xlsx"
download.file("http://www.journalofaccountancy.com/content/dam/jofa/issues/2017/jan/general-ledger-collins.xlsx", 
              "t.xlsx", method = "curl")
if (!file.exists(destfile)) {
  setInternet2(TRUE)
  download.file(fileURL ,destfile,method="curl") }
### http://www.journalofaccountancy.com/issues/2017/jan/general-ledger-data-mining.html
install.packages("compare")
library(compare)
## Read in data and convert xlsx to csv 
install.packages("rio")
install.packages("xlsx")
library(xlsx)
library(rio)
dat<-read.xlsx2("data.xlsx", sheetName = "QuickBooks GL Report", colClasses = c("character","character","character","character","character","character","character","Date"))
## If you open the xlsx file, the dates are wrong!
convert("data.xlsx", "dat.csv")
dat<-read.csv("dat.csv")
## No problems with dates in csv format
## Check percentage of NAs in test set
colMeans(is.na(dat))*100
## remove columns with greater than 99% NAs 
datNoNA <- dat[, -which(colMeans(is.na(dat)) > 0.99)]
## remove rows with greater than 99% NAs 
datNoNA2 <- datNoNA[-which(rowMeans(is.na(datNoNA)) > 0.99), ]
## copy down names from column 1

## remove rows without a date
datNoNA2 <- datNoNA[-which(is.na(datNoNA$Date)), ]
colMeans(is.na(datNoNA2))*100
comp<-compare(datNoNA, datNoNA2, allowAll = TRUE)
comp$tM
## Remove rows at the end
## head(datNoNA,n=10)
## tail(datNoNA, n=10)
## datTrim<- datNoNA[c(-1,-5447:-5455),]
