# Author - Anupama Rajaram
# Program Description - Create bubble charts showing crime rates per district.

# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))

# Load libraries 
library(ggplot2)
library(ggvis)
library(data.table)  # to use fread()


# Load some default preferences for number formatting
options(digits=7)


crimesfo <- fread("sfo_crime.csv") 
# 10 rows and 41 columns.

radius <- sqrt( crimesfo$popl/ pi )

# add color and format axes.
# we use fg to change border color, bg to change fill color
symbols(crimesfo$LARCENY.THEFT, crimesfo$ASSAULT, circles=radius, inches=0.35, 
        fg="white", bg="red", xlab="Larceny CrimeRates", 
        ylab="Assault Crimerates")
text(crimesfo$LARCENY.THEFT, crimesfo$ASSAULT, crimesfo$area, cex=0.5)


# Similar bubble plot using ggplot library functions.
 p1 = ggplot(crimesfo, aes(x = area, y = (LARCENY.THEFT/popl)*100), 
        label = area) + 
   geom_point(color = "blue", aes(size = LARCENY.THEFT))
 
 p1 + ggtitle("Plot") +
   xlab("District") + ylab("Theft as % of District Population")



