#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from 
# Author: Yongpeng Hua
# Data: 8 December 2020
# Contact: yongpeng.hua@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
library(labelled)
# set to your own path where the data is located
setwd("/Users/hyp/Desktop/304-final-project-main")

# Read in the raw data
raw_data_census <- read.csv("gss 2017.csv")

# Add the labels
raw_data_census <- labelled::to_factor(raw_data_census)

# keep some variables
reduced_data_census <- 
  raw_data_census %>% 
  select(sex,
         ehg3_01b,
         agec,
         cow_10
  )

# rename
reduced_data_census <- reduced_data_census %>% 
  rename(age = agec) %>% 
  rename(employment = cow_10) %>% 
  rename(education = ehg3_01b)

write_csv(reduced_data_census, "/Users/hyp/Desktop/304-final-project-main/census_data.csv")

