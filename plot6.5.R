#we are going to use dplyr to Wrangle the data.
library(dplyr)
library(ggplot2)
library(data.table)

#lets load the huge data file. we dont need the other data file for this exercise..
MLP <- read.csv("D:/git.repos/R-Repo/Data/MLPoutput.csv")

#lets use dplyr to manipulate data, first filter date for Baltimore, then  group by year, 
#then summarize - the sum of emmision by the year and then convert them to kilotons..
results = MLP %>%
      filter(School  %like% 'Florida' & (Count== 2014 | Count == 2013) & CR < 500) 
      #group_by(year, fips) %>%
      #summarise(sum = sum(Emissions)) %>%
      #mutate(city = ifelse(fips=="24510", "Baltimore", "Los Angeles"))

ggplot(data=results, aes(x=reorder(as.numeric(CR),factor(School)), y=School)) + 
      geom_segment(aes(yend=School), xend=0, color="grey50") + 
      geom_point(aes(color=factor(Count))) + 
      theme_bw() +
      theme(legend.position="none") +
      facet_grid(Count ~., scales = "free_y", space = "free_y") # +
      #scale_fill_discrete(guide = FALSE)
      #theme(panel.grid.major.x = element_blank(),
      #      panel.grid.minor.x = element_blank(),
      #      #panel.grid.major.y = element_line(color="grey60", linetype = "dashed"),
      #     legend.title = element_text("test")) 
      #labs(x = "Year", y = "PM2.5 Emission", title = "PM2.5 Emission by City")

ggsave(filename = "plot6.5.png")

