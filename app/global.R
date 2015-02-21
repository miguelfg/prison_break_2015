library(markdown)
require(rCharts)


#######################
# GLOBAL FUNCS
#######################

getData <- function(ini, fin){
  data <- get(load('data/presos.prop.total.rda'))
  data <- data[(data$year>=ini & data$year<=fin), ]
  data
}