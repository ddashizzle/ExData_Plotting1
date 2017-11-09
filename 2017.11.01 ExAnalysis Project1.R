

#Load Data
  #Download the data and extract (skip this step if already downloaded and extracted)
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  fileLocal <- "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, fileLocal)
  unzip(fileLocal, exdir = "./data")

  #calculate memory requirements
  fileData <- './data/household_power_consumption.txt'
  file.info(fileData)$size
  
  #Returns
  # > file.info(fileData)$size
  # [1] 132960755
  # 
  #Memory requirement has a rough estimate of ~127MB
  
  #Read in data, correct data type and subset
    #Read in
    powerData <- read.csv(fileData, header = TRUE, sep = ";", stringsAsFactors = FALSE)
    
    #correct data type (date and numerics)
    #note: all missing values denoted as '?' will be replaced by NAs
    powerData[,1] <- as.Date(powerData[,1], '%d/%m/%Y')
    sapply(3:9, FUN = function(x) powerData[, x] <<- as.numeric(powerData[, x]))
    
    #subset data to target dates
    subsetData <- subset(powerData, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

  #Test actual memory usage
  # > object.size(powerData)
  # 149501208 bytes
  #
  #Actual memory requirement is ~142MB
    
  #Free memory/drop unused data
  rm(powerData)
  
#Making Plots
  
  #Plot1.png
  pngName <- './data/plot1.png'
  png(pngName)
  hist(subsetData$Global_active_power, 
       col = 'red', 
       main = 'Global Active Power', 
       xlab = 'Global Active Power (kilowatts)')
  dev.off()
  
  
  