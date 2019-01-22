#' UCDP Map
#'
#' takes UCDP data and makes a map
#' @author Mike Kozel
#' @return Map of conflicts
#' @export



# map function
map_plot <- function(){

  mapWorld <- borders("world")
  mp <- ggplot() +   mapWorld

  #Now add conflicts
  map <- mp + geom_point(data=df1, aes(x=df1$longitude, y=df1$latitude), size=2)

  return(map)
}
