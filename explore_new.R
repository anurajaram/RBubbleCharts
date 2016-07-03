# author - Anupama Rajaram 
# modified using script from Kaggle forum, by Tom Dallas.


# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))

# laod libraries needed for execution
library(data.table) # for fread()
library(dplyr)
library(leaflet)    # for map view
library(htmltools)
library(varhandle)  # for unfactor()


# preferences for decimal places
options(digits=3)

# read education data
df <- fread("Scorecard.csv", stringsAsFactors = TRUE)


sel_rows2 = c("UNITID",         ## institution ID
             "INSTNM",         ## institution name
             "CITY",           ## institution city
             "STABBR",         ## institution state abbrev
             "ZIP",            ## institution zip
             "PREDDEG",        ## predominate degree
             "CURROPER",       ## currently operating flag
             "TUITIONFEE_IN",  ## in-state tuition and fees
             "LATITUDE",       ## latitude
             "LONGITUDE",      ## longitude
             "DISTANCEONLY",   ## distance only flag
             "ADM_RATE",   ## admission rate 
             "AVGFACSAL",     ## Average Faculty Salary
             "DEBT_MDN" ,   ## median debt
             "PAR_ED_PCT_1STGEN", ##  first generation student
             "pct_white"    ## ratio of white students
             )

# selecting only the variables we need for exploration and visualization
sch_demog = subset(df, select = sel_rows2)




# checkin for NAs
sapply(sch_demog, function(x) sum(is.na(x)))


# compute admission rate
sch_demog$adm = sch_demog$ADM_RATE
sch_demog$adm[is.na(sch_demog$adm)] = "unreported"

# Faculty Salary
sch_demog$profsal = sch_demog$AVGFACSAL
sch_demog$profsal[is.na(sch_demog$profsal)] = "unreported"


# information on location markers
collegeInfo <- paste(sch_demog[['INSTNM']], "<br>", ", ", 
                     sch_demog[['CITY']], ", ", sch_demog[['STABBR']], "<br>", ", ",
                     "Acceptance Rate = ", sch_demog[['adm']], "<br>", ", ",
                     "Faculty Salary = ", sch_demog[['profsal']], "<br>", 
                     sep='')
sch_demog$infos = collegeInfo

# test -check formatting of "infos" variable
sch_demog[34120:34125, infos]



## filter data for admission rate & demographics visualization
demog<-subset(sch_demog,
                  CURROPER=="Currently certified as operating" & 
                  ## Currently operating
                  DISTANCEONLY=="Not distance-education only" &  
                  ## Not distance
                  is.na(TUITIONFEE_IN)==FALSE &       ## Key measurements aren't missing
                  is.na(LATITUDE)==FALSE &
                  is.na(LONGITUDE)==FALSE &
                  LATITUDE>20 & LATITUDE<50 &         ## Location is US 48
                  LONGITUDE>(-130) & LONGITUDE<(-60))


schools<-subset(sch_demog,
                PREDDEG=="Predominantly bachelor's-degree granting" &  
                  ## Predominate degree is BS
                  CURROPER=="Currently certified as operating" & 
                  ## Currently operating
                  DISTANCEONLY=="Not distance-education only" &  
                  ## Not distance
                  is.na(TUITIONFEE_IN)==FALSE &       ## Key measurements aren't missing
                  is.na(LATITUDE)==FALSE &
                  is.na(LONGITUDE)==FALSE &
                  LATITUDE>20 & LATITUDE<50 &         ## Location is US 48
                  LONGITUDE>(-130) & LONGITUDE<(-60))



# create map to show univ details
map_demog <- leaflet(demog) %>% 
  setView(-93.65, 42.0285, zoom = 4) %>%
  addTiles() %>%
  addMarkers(~LONGITUDE, ~LATITUDE, popup=~infos,
             options = popupOptions(closeButton = TRUE),
             clusterOptions = markerClusterOptions() 
             )
map_demog


