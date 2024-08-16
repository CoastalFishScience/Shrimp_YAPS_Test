##Cleaning code for HR2 data
#Authors: Jon Rodemann and Rolando Santos
#Packages
library(tidyverse)
library(splitstackshape)
library(chron)
library()

HR2_list <- list.files("./Data/", full.names = TRUE)
files_all <- function(x){
  df <- lapply(x, read_csv, skip = 37, col_names = FALSE,) %>% 
    # subset(., X1 %in% c("DET"))%>%
    # bind_rows %>% 
    plyr::rbind.fill %>%
    subset(., select = 1:13) %>%
    
    mutate(X10 = as.character(X10))  #mutate here is to force X10 as character so I can use rbind later and transfer the number/name of object within the list as a column
  
}

HR2_all <- lapply(HR2_list, read_csv, skip = 37, col_names = FALSE) %>% 
  # subset(., X1 %in% c("DET"))%>%
  # bind_rows %>% 
  list_rbind() #%>%
  #subset(., select = 1:13)

