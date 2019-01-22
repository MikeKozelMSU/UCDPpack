#' Sum Stats
#' produces summary statistics
#'
#' @author Mike Kozel
#' @return a graph of averages
#' @export

#sum stat function
sum_stat <- function(df1){
  #convert lat/long into a numeric
  df1$longitude <- as.numeric(df1$longitude)
  df1$latitude <- as.numeric(df1$latitude)

  df1$random <- as.Date(paste(df1$year, 1, 1, sep="-"))

  #convert dates into characters
  df1$date_end <- as.character(df1$date_end)
  df1$date_start <- as.character(df1$date_start)

  #reformat date structure
  df1$date_end <- as.Date(df1$date_end, format = "%m/%d/%Y")
  df1$date_start <- as.Date(df1$date_end, format = "%m/%d/%Y")

  df1$date_end <- format(df1$date_end, "%d/%m/%Y")
  df1$date_start <- format(df1$date_start, "%d/%m/%Y")

  #create vectors of low, high, year, region, best estimate
  low_est <- as.numeric(df1$low)
  high_est <- as.numeric(df1$high)
  year <- df1$year
  region <- df1$region
  best_est <- as.numeric(df1$best)

  ## create new dataframe based on region with low, best and high
  df2 <- data.frame(year, region)
  df2$low_est <- low_est
  df2$high_est <- high_est
  df2$best_est <- best_est

  # make region and year character and number, and add country ID
  df2$region <- as.character(df2$region)
  df2$year <- as.numeric(df2$year)
  df2$country_id <- df1$country_id

  # find averages
  df3 <- df2 %>%
    group_by(region) %>%
    summarise(mean_best=mean(best_est),
              mean_low=mean(low_est),
              mean_high=mean(high_est))


  # melt data by region
  as.character(df3$region)
  df5 <- melt(df3, id.vars = 'region')

  # make graph
  graph <- ggplot() +
    geom_bar(data=df5, aes(x=region, y=value, fill=variable), stat = 'identity') +
    labs(x='', y='Mean Casualties Per Conflict') +
    theme_bw() +
    theme(legend.title = element_blank(),
          axis.text.x = element_text(angle=45, size=10),
          axis.ticks = element_blank(),
          panel.border = element_blank()) +
    scale_y_continuous(breaks=seq(0,120, 10), limits=c(0,120)) +
    ggtitle("Average Number of Casualties from Conflict")

  #produces graph
  return(graph)
}
