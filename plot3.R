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
ggplot(data=results, aes(x=year, y=sum)) + 
      facet_grid(.~ type) + 
      geom_line(size=1, alpha=.5, color="red") + 
      geom_point(color="red", size=2) + 
      geom_smooth(method='lm',formula=y~x, color="gray50") +
      labs(x = "Year", y = "PM2.5 Emission", title = "Emission by Source Type")

ggsave(filename = "plot3.png")
