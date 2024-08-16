##YAPS run for shrimp test
#Authors: Jon Rodemann and Rolando Santos
library(tidyverse)
library(yaps)
library(data.table)

acoustic <- data.table::fread('HR2_VUE.csv', fill=TRUE)
str(acoustic)
acoustic$`Date and Time (UTC)` <- as.character(acoustic$`Date and Time (UTC)`)
detections <- prepDetections(raw_dat = acoustic, type='vemco_vue')

head(detections)
