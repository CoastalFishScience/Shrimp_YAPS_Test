##YAPS run for shrimp test
#Authors: Jon Rodemann and Rolando Santos
library(tidyverse)
library(yaps)
library(data.table)

acoustic <- data.table::fread('HR2_VUE.csv', fill=TRUE)
str(acoustic)
acoustic$`Date and Time (UTC)` <- as.character(acoustic$`Date and Time (UTC)`)

#get rid of shrimp receiver
acoustic <- acoustic %>% filter(Receiver != 'HR2-461360')


detections <- prepDetections(raw_dat = acoustic, type='vemco_vue')
hydros <- data.table::fread('./Data/hydros.csv')

#set parameters
max_epo_diff <- 15
min_hydros <- 3
time_keeper_idx <- 3
fixed_hydros_idx <- c(1, 2, 3)
n_offset_day <- 2
n_ss_day <- 2
keep_rate <- 1

shrimp <- list(hydros, detections)
names(shrimp) <- c('hydros', 'detections')
shrimp$hydros$sync_tag <- as.double(shrimp$hydros$sync_tag)
shrimp$detections$tag <- as.integer(shrimp$detections$tag)
shrimp$detections$epo <- as.integer(shrimp$detections$epo)
shrimp$detections$serial <- as.integer(shrimp$detections$serial)

inp_sync <- getInpSync(sync_dat = shrimp, max_epo_diff, min_hydros, time_keeper_idx,
                       fixed_hydros_idx, n_offset_day, n_ss_day, keep_rate)

