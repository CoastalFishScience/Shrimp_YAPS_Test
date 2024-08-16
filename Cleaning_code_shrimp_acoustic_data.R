##Cleaning code for HR2 data
#Authors: Jon Rodemann and Rolando Santos
#Packages
library(tidyverse)
library(splitstackshape)
library(chron)
library(yaps)
library(data.table)


HR2_list <- list.files("./Data/", full.names = TRUE)

HR2_all <- lapply(HR2_list, read_csv, skip = 37, col_names = FALSE) %>% 
  # subset(., X1 %in% c("DET"))%>%
  # bind_rows %>% 
  list_rbind() #%>%
  #subset(., select = 1:13)

colnames(HR2_all)<-c("Type", "Date.Time.UTC", "Date.Time.Offset", "trash",
                        "Time.Offset", "Model",
                        "Receiver.ID", "Detection.Type", "ID",
                        "Full.ID", "Signal.DB", "Noise.DB", 'Q.score')

HR2_all_det <- HR2_all %>% dplyr::filter(Type == 'DET') %>% select(-c(trash, Signal.DB, Noise.DB, Q.score)) 

#Change the HR2 output into vue output
HR2 <- HR2_all_det

HR2_1 <- HR2 %>% select(c(Date.Time.Offset, Model, Receiver.ID, Full.ID, Detection.Type)) %>% dplyr::filter(Detection.Type == 3) %>% 
  mutate(Receiver = paste(Model, Receiver.ID, sep = '-')) %>% select(-c(Model, Receiver.ID, Detection.Type)) %>% rename('Date.and.Time..UTC.' = Date.Time.Offset, 'Transmitter' = Full.ID) %>% 
  mutate(Transmitter.Name = NA, Transmitter.Serial = NA, Sensor.Value = NA, Sensor.Unit = NA, Statione.Name = NA, Latitude = NA, Longitude = NA, Transmitter.Type = NA, Sensor.Precision = NA)

write.csv(HR2_1, file = 'C:/Users/jonro/OneDrive/Documentos/Shrimp_YAPS_Test/HR2_VUE.csv')
                   
