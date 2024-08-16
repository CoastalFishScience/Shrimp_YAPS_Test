##plotting GPS data to compare

library(tidyverse)
library(sf)


receivers <- read.csv('./Data/receivers_GPS.csv')
head(receivers)
receivers$Receiver_Code <- as.factor(receivers$Receiver_Code)

sfdat <- receivers %>% 
  st_as_sf(coords = c('X1', 'Y1')) %>% #set up the coordinates
  st_set_crs(32620)
sfdat2 <- receivers %>% 
  st_as_sf(coords = c('X2', 'Y2')) %>% #set up the coordinates
  st_set_crs(32620)

head(sfdat)
sfdat$Receiver_Code <- as.factor(sfdat$Receiver_Code)
sfdat2$Receiver_Code <- as.factor(sfdat2$Receiver_Code)

#We can now graph this in ggplot
ggplot() +
  geom_sf(data = sfdat, size = 3, aes(color = Receiver_Code))

ggplot()+
  geom_point(data = receivers, aes(x = X1, y = Y1, color = Receiver_Code))
