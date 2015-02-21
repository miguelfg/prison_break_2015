library(ggplot2)
library(ggmap)

#######################
# GLOBAL FUNCS
#######################

getData <- function(ini, fin){
  data <- get(load('data/presos.prop.total.rda'))
  data <- data[(data$year>=ini & data$year<=fin), ]
  print(head(data))
  data
}