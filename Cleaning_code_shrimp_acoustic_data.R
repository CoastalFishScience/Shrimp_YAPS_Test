##Cleaning code for HR2 data
#Authors: Jon Rodemann and Rolando Santos
#Packages
library(tidyverse)
library(splitstackshape)
library(chron)
library(yaps)


HR2_list <- list.files("./Data/", full.names = TRUE)

HR2_all <- lapply(HR2_list, read_csv, skip = 37, col_names = FALSE) %>% 
  # subset(., X1 %in% c("DET"))%>%
  # bind_rows %>% 
  list_rbind() #%>%
  #subset(., select = 1:13)

colnames(HR2_all)<-c("Type", "Date.Time.UTC", "Date.Time.Offset", "trash",
                        "Time.Offset", "Model",
                        "Receiver.ID", "Detection.Type", "Full.ID",
                        "ID", "Signal.DB", "Noise.DB", 'Q.score')

HR2_all_det <- HR2_all %>% dplyr::filter(Type == 'DET') %>% select(-c(trash, Signal.DB, Noise.DB, Q.score)) 

#