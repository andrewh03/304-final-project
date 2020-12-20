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


