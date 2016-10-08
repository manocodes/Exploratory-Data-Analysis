#we are going to use dplyr to Wrangle the data.
library(dplyr)
library(ggplot2)
library(data.table)

#lets load the huge data file. we dont need the other data file for this exercise..
SCC <- readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/Source_Classification_Code.rds")
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets filter out coal related records
coalrel = filter(SCC, Short.Name %like% 'Vehicle' | Short.Name %like% 'vehicle')

#then lets join it to make a combined table..
NEI = inner_join(NEI, coalrel, by="SCC")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year, 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = NEI %>%
      filter(fips == "24510" | fips == "06037") %>%
      group_by(fips, year) %>%
      summarise(sum = sum(Emissions))

ggplot(data=results, aes(x=year, y=sum)) + 
      facet_grid(.~ fips) + 
      geom_line(size=1, alpha=.5, color="red") + 
      geom_point(color="red") + 
      labs(x = "Year", y = "PM2.5 Emission", title = "Emission by City")

ggsave(filename = "plot6.png")

