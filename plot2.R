# File household_power_consumption.txt must exist in work directory
if(file.exists("household_power_consumption.txt")){
  # Needed because by computer speaks Spanish :)
  Sys.setlocale("LC_TIME","English")
  
  # For plot1 only reads column 1 and 3
  # I search the first row of '1/2/2007' con
  # grep("01/02/2007","household_power_consumption.txt")
  # For each day we have 1440 observations (1 per minute)
  # So i get the values 66637 y 2880
  datos <- read.table("household_power_consumption.txt", 
                      header=FALSE,
                      sep=";", 
                      na.strings="?", 
                      nrows=2880,
                      skip=66637,
                      colClasses=c("character","character",NA,"NULL","NULL",
                                   "NULL","NULL","NULL","NULL"),
                      col.names=c("Date","Time","Global_active_power","","","",
                                  "","",""),
                      comment.char=""
  )
  #Transform dates
  datos <- transform(datos,Date=as.Date(Date,"%d/%m/%Y"),
                     Time=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
  
  par(bg="transparent")
  par(mar=c(4,3.9,3.2,1))
  plot(datos[,2],datos[,3],type="l",xlab="",
       ylab="Global Active Power (kilowatts)",cex.lab=0.8,cex.axis=0.8)
  dev.copy(png,file="plot2.png")
  dev.off()
}