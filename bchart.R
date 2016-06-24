# Author - Anupama Rajaram
# Stacked graphs


# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))

# load standard libraries (not all are used, though)
library(data.table)
library(dplyr)
library(plotly)
library(ggplot2)
library(ggvis)

options(digits=7) # numeric values will have 7 decimal digits.

# load data
mytrain = fread("train.csv", stringsAsFactors = TRUE)


# stripping Dates variable for date time manipulation
mytrain$dt = as.Date(mytrain$Dates)
mytrain$year = as.numeric(format(mytrain$dt, "%Y"))




# Horizontal Bar chart in ascending order.
data_plot = mytrain %>%
  group_by(Category) %>%
  summarise(count = n()) %>%
  transform(Category = reorder(Category,-count))

ggplot(data_plot) + 
  geom_bar(aes(x=Category, y=count),
           stat="identity")+
  coord_flip()+
  theme(legend.position="None")+
  ggtitle("Number of crimes in individual category")+
  xlab("Number of crimes")+
  ylab("Category of crime")



# bar chart side stacking
px = ggplot(data = mytrain, aes(x = PdDistrict, fill = DayOfWeek)) +
  geom_bar(position = "dodge")
ggplotly(px)


# Stacked bar charts
py = ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
ggplotly(py)


