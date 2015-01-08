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
                      colClasses=c("character","character","numeric","numeric",
                                   "numeric","NULL","numeric","numeric",
                                   "numeric"),
                      col.names=c("Date","Time","Global_active_power",
                                  "Global_reactive_power","Voltage","",
                                  "Sub_metering_1","Sub_metering_2",
                                  "Sub_metering_3"),
                      comment.char=""
  )
  #Transform dates
  datos <- transform(datos,Date=as.Date(Date,"%d/%m/%Y"),
                     Time=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
  
  par(bg="transparent")
  par(mfrow= c(2,2))
  par(mar=c(4.5,3.9,3.1,1.6))
  
  # Graph 1
  plot(datos[,2],datos[,3],type="l",xlab="",
       ylab="Global Active Power",cex.lab=0.8,cex.axis=0.8)
  
  # Graph 2
  plot(datos[,2],datos[,5],type="l",xlab="datetime",
       ylab="Voltage",cex.lab=0.8,cex.axis=0.8)
  
  
  # Graph 3  
  plot(datos[,2],datos[,6],type="l",xlab="",
       ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8)
  lines(datos[,2],datos[,7],type="l",xlab="",ylab="",col="red")
  lines(datos[,2],datos[,8],type="l",xlab="",ylab="",col="blue")
  legend("top",col=c("black","red","blue"),cex=0.8,lty=1,seg.len=2,
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         y.intersp=0.5,text.font=1.2,bty="n")
  
  # Graph 4  
  plot(datos[,2],datos[,4],type="l",xlab="datetime",
       ylab="Global_reactive_power",cex.lab=0.8,cex.axis=0.8)
    
  # Export to PNG
  dev.copy(png,file="plot4.png")
  dev.off()
}