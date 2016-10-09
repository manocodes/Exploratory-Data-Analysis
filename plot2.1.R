#we are going to use dplyr to Wrangle the data.
library(dplyr)
library(ggplot2)

#lets load the huge data file. we dont need the other data file for this exercise..
NEI = readRDS("D:/git.repos/R-Repo/Data/Air Quality/exdataNEI_data/summarySCC_PM25.rds")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year, 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = NEI %>%
      filter(fips == "24510") %>%
      group_by(year) 

ggplot(results, aes(x=factor(year))) + geom_bar()

ggsave(filename = "plot2.1.png")