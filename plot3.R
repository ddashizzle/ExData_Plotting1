
#Run pullData() only if the data has not been previously downloaded and placed in the ./data directory
#pullData()

#Ensure output dir exists
if(!file.exists("./output")){dir.create("./output")}

#Read in data, correct data type and subset
  #Read in
  fileData <- './data/household_power_consumption.txt'
  powerData <- read.csv(fileData, header = TRUE, sep = ";", stringsAsFactors = FALSE)
  
  #correct data type (date and numerics)
  #note: all missing values denoted as '?' will be replaced by NAs
  powerData[,1] <- as.Date(powerData[,1], '%d/%m/%Y')
  powerData[,2] <- with(powerData, as.POSIXct(paste(Date, Time), '%d/%m/%Y %H:%M:%S'))
  sapply(3:9, FUN = function(x) powerData[, x] <<- as.numeric(powerData[, x]))
  
  #subset data to target dates
  subsetData <- subset(powerData, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

#Making Plots
  #Plot3.png
  pngName <- './output/plot3.png'
  png(pngName)
  with(subsetData, plot(Time, 
                        Sub_metering_1, 
                        type = 'n',
                        xlab = '',
                        ylab = 'Energy sub metering'))
  with(subsetData, lines(Time, Sub_metering_1))
  with(subsetData, lines(Time, Sub_metering_2, col = 'red'))
  with(subsetData, lines(Time, Sub_metering_3, col = 'blue'))
  
  dev.off()



pullData <- function() {
  #Download and extract to the ./data directory all data needed for Exploratory Analysis project 1
  #This only needs to be run once for the project
  
  #Download the data and extract (skip this step if already downloaded and extracted)
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  fileLocal <- "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, fileLocal)
  unzip(fileLocal, exdir = "./data")
  
}

