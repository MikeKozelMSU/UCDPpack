library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(httr)
library(jsonlite)
library(ggplot2)
library(ggmap)
library(reshape2)

#' UCDP Data
#'
#' loads in UCDP data from API
#' @author Mike Kozel
#' @return database of UCDP data
#' @export

#get the data from UCDP API
data <- GET("http://ucdpapi.pcr.uu.se/api/gedevents/17.2?pagesize=50")

# pull the content out of the data
data_content <- content(data)

# create a null dataframe to store data in
df1 <- data.frame(NULL)

# for loop to bind data from content into a dataframe
for(i in 1:50){
    result <- as.data.frame(data_content$Result[[i]])
    df1 <- rbind(result, df1)
  }



