# There are no functions defined in this script. source() the file to run it.

# Load libraries, stop if any of them is not available
if(!require(readr))
    stop('readr is required to run this script. Please install it before trying again.')

if(!require(dplyr))
    stop('dplyr is required to run this script. Please install it before trying again.')

# Check if the data file exists in the working directory
if(!file.exists('household_power_consumption.txt'))
    stop('household_power_consumption.txt is missing from the working directory')

# Read the file
hpower_complete <- read_delim('household_power_consumption.txt', delim = ';', 
                              col_types = c('ccnnnnnnn'), na = '?')

# Create Date2 as Date type to filter later
hpower_complete$Date2 <- as.Date(hpower_complete$Date, format = '%d/%m/%Y')

# Filter only the dates needed
hpower <- filter(hpower_complete, Date2 >= '2007-02-01' & Date2 <= '2007-02-02')

# Remove the whole dataset to save memory
rm(hpower_complete)

# Remove Date2, no longer needed
hpower$Date2 <- NULL

# Combine Date and Time in a single field
hpower$Date <- paste(hpower$Date, hpower$Time)

# Remove Time, no longer needed
hpower$Time <- NULL

# Convert Date (Date and Time) to POSIXlt
hpower$Date <- strptime(hpower$Date, format = '%d/%m/%Y %H:%M:%S')

# Open a PNG device
png(filename = 'plot2.png', bg = 'transparent', width = 480, height = 480)

# Plot the lines graph (type = 'l')
with(hpower, plot(Date, Global_active_power, type = 'l',
                  ylab = 'Global Active Power (kilowatts)', xlab = ''))

# Close the device so we can open the file in the OS
dev.off()

# Notify the user that the plot was saved to a file
message('plot2.png generated in the working directory')