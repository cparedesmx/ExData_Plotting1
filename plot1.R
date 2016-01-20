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

# Convert Date (field) to class Date
hpower_complete$Date <- as.Date(hpower_complete$Date, format = '%d/%m/%Y')

# Filter only the dates needed
hpower <- filter(hpower_complete, Date >= '2007-02-01' & Date <= '2007-02-02')

# Remove the whole dataset to save memory
rm(hpower_complete)

# Open a PNG device
png(filename = 'plot1.png', bg = 'transparent', width = 480, height = 480)

# Plot the histogram
hist(hpower$Global_active_power, col = 'red',
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')

# Close the device so we can open the file in the OS
dev.off()

# Notify the user that the plot was saved to a file
message('plot1.png generated in the working directory')