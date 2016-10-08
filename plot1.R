#we are going to use dplyr to Wrangle the data.
library(dplyr)

#lets load the huge data file. we dont need the other data file for this exercise..
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets use dplyr to manipulate data, first to group by year, then summarize - the sum of emmision
#by the year and then convert them to kilotons..
results = NEI %>% 
      group_by(year) %>%
      summarise(sum = sum(Emissions)) %>%
      mutate(sum = sum/1000)

png(filename = "plot1.png")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
with(results, barplot(sum, names.arg = year, 
                      main = expression('Total emission of pm'[2.5]), 
                      xlab = "Year", 
                      ylab = expression(paste('Total emission of pm'[2.5],' in Kilotons'))))

dev.off()

#as we see we there is a constant decrese of PM2.5 over the years. 