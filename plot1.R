# downloads the file.

if(!file.exists("data.zip")|!file.exists("household_power_consumption.txt"))
{
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data.zip")
        unzip("data.zip")
}



# this command read only values of two dates of february month in year 2007 


# Logic is :- 
# 1) read.table("file") is nothing but a data frame
# 2) We can subset read.table("file") using "which()" function. Thereby ,filtering data for required dates.
#
# variable <- read.table("file")[which(read.table("file")[1]=="req_date"),]

data_piece <-  read.table("household_power_consumption.txt",sep = ";",header = TRUE,colClasses = rep(c("character"),9))[which((read.table("household_power_consumption.txt",sep = ";",header = TRUE)[1] == "1/2/2007") | (read.table("household_power_consumption.txt",sep = ";",header = TRUE)[1] == "2/2/2007")),]

# serializing the row names
rownames(data_piece) <- c(1:length(data_piece[,1]))

# Fomatting the dates 

t <- format(data_piece[,1])     # send the date vector to format function
t <-  strptime(t,"%d/%m/%Y")    # strptime(formatted_vector,"%d/%m/%Y)
data_piece[,1] <- as.Date(t)    #  pass the above result through as.Date() to remove time zone

# converting all the columns to numeric data type

col <- c(3:ncol(data_piece))
data_piece[,col] <- apply(data_piece[,col],2,function(x) as.numeric(x))

#converting Time  to "time" data type.






# Plot 1 :- hist of global active power (kilowats)
plot.new()

if(!dir.exists("figure"))
{
        dir.create("figure")
}

png("figure/plot1.png", width = 480,height =480)
hist(data_piece$Global_active_power,col = "Red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

dev.off() # save the plot
