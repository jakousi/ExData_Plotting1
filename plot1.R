# File household_power_consumption.txt must exist in work directory
if(file.exists("household_power_consumption.txt")){
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
                      colClasses=c("NULL","NULL",NA,"NULL","NULL","NULL","NULL","NULL","NULL"),
                      col.names=c("","","Global_active_power","","","","","",""),
                      comment.char=""
  )
  
  par(bg="transparent")
  hist(datos[,1],
       xlab = "Global Active Power (kilowatts)",
       main="Global Active Power",
       col="red",cex.lab=0.8,cex.main=0.9)
  dev.copy(png,file="plot1.png")
  dev.off()
}