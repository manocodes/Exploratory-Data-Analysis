#we are going to use dplyr to Wrangle the data.
library(dplyr)
library(ggplot2)

#lets load the huge data file. we dont need the other data file for this exercise..
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year and , 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = NEI %>%
      filter(fips == "24510") %>%
      group_by(type, year) %>%
      summarise(sum = sum(Emissions))

#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999–2008 for Baltimore City? 
ggplot(data=results, aes(x=factor(year), y=sum, fill=type)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(x = "Year", y = "PM2.5 Emission", title = "Emission by Source Type")

ggsave(filename = "plot3.1.png")
