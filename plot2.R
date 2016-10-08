#we are going to use dplyr to Wrangle the data.
library(dplyr)

#lets load the huge data file. we dont need the other data file for this exercise..
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year, 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = NEI %>%
      filter(fips == "24510") %>%
      group_by(year) %>%
      summarise(sum = sum(Emissions))

png(filename = "plot2.png")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? 
with(results, barplot(sum, names.arg = year, 
                      main = expression('Baltimore - Total emission of pm'[2.5]), 
                      xlab = "Year", 
                      ylab = expression(paste('Total emission of pm'[2.5]))))

dev.off()

#as we see we there there is a general up and down trend. 