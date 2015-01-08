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
                      colClasses=c("character","character","NULL","NULL","NULL",
                                   "NULL","numeric","numeric","numeric"),
                      col.names=c("Date","Time","","","","",
                                  "Sub_metering_1","Sub_metering_2",
                                  "Sub_metering_3"),
                      comment.char=""
  )
  #Transform dates
  datos <- transform(datos,Date=as.Date(Date,"%d/%m/%Y"),
                     Time=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
  
  par(bg="transparent")
  par(mar=c(5,3.9,3.2,1))
  plot(datos[,2],datos[,3],type="l",xlab="",
       ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8)
  lines(datos[,2],datos[,4],type="l",xlab="",ylab="",col="red")
  lines(datos[,2],datos[,5],type="l",xlab="",ylab="",col="blue")
  legend("topright",col=c("black","red","blue"),cex=0.7,lty=1,seg.len=3,
         legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "),
         y.intersp=0.7,text.font=2)
  dev.copy(png,file="plot3.png")
  dev.off()
}