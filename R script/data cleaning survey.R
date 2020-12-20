#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/DUS88V
# Author: Yongpeng Hua
# Data: 21 December 2020
# Contact: yongpeng.hua@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
library(labelled)
# set to your own path where the data is located
setwd("/Users/hyp/Desktop/304-final-project-main")

# Read in the raw data
raw_data_survey <- read_dta("2019 Canadian Election Study - Online Survey v1.0.dta")

# Add the labels
raw_data_survey <- labelled::to_factor(raw_data_survey)

# keep some variables
reduced_data_survey <- 
  raw_data_survey %>% 
  select(cps19_votechoice,
         cps19_citizenship,
         cps19_gender,
         cps19_education,
         cps19_age
         )

# mutate a binary variable for outcome
reduced_data_survey <- reduced_data_survey %>% 
  mutate(vote_liberal = 
           ifelse(cps19_votechoice == "Liberal Party", 1, 0))

# mutate some variables to clean up

