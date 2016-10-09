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
      summarise(sum = sum(Emissions)) %>%
      mutate(city = ifelse(fips=="24510", "Baltimore", "Los Angeles"))

ggplot(data=results, aes(x=factor(year), y=sum, fill=city)) + 
      geom_bar(stat = "identity", position="dodge") +
      scale_fill_brewer(palette = "Pastel1") +
      geom_text(aes(label=format(sum, digits=0)), vjust = 1, color= "white", position=position_dodge(.9), size=3) +
      labs(x = "Year", y = "PM2.5 Emission", title = "PM2.5 Emission by City")

ggsave(filename = "plot6.3.png")

