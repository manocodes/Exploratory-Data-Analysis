#we are going to use dplyr to Wrangle the data.
library(dplyr)
library(ggplot2)
library(data.table)

#lets load the huge data file. we dont need the other data file for this exercise..
SCC <- readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/Source_Classification_Code.rds")
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets filter out coal related records
coalrel = filter(SCC, Short.Name %like% 'Coal' | Short.Name %like% 'coal')

#then lets join it to make a combined table..
NEI = inner_join(NEI, coalrel, by="SCC")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year, 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = NEI %>%
      group_by(year) %>%
      summarise(sum = sum(Emissions))%>%
      mutate(sum = sum/1000)

png(filename = "plot4.png")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
with(results, barplot(sum, names.arg = year, 
                      main = expression('Total emission of pm'[2.5]), 
                      xlab = "Year", 
                      ylab = expression(paste('Total emission of pm'[2.5],' in Kilotons'))))

dev.off()
