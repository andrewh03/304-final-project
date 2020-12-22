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
         cps19_gender,
         cps19_education,
         cps19_age
         )

# mutate a binary variable for outcome
reduced_data_survey <- reduced_data_survey %>% 
  mutate(vote_liberal = 
           ifelse(cps19_votechoice == "Liberal Party", 1, 0))

# mutate some variables to clean up
reduced_data_survey <- reduced_data_survey %>% 
  mutate(cps19_gender = case_when(
    cps19_gender == "A man" ~ "Male",
    cps19_gender == "A woman" ~ "Female", 
    cps19_gender == "Other (e.g. Trans, non-binary, two-spirit, gender-queer)" ~ "Don't know"
  ))

reduced_data_survey <- reduced_data_survey %>% 
  mutate(cps19_education = case_when(
    cps19_education == "Bachelor's degree" ~ "Bachelor's degree (e.g. B.A., B.Sc., LL.B.)",
    cps19_education == "Master's degree" ~ "University certificate, diploma or degree above the bach...", 
    cps19_education == "Some technical, community college, CEGEP, College Classique" ~ "College, CEGEP or other non-university certificate or di...",
    cps19_education == "Completed secondary/ high school" ~ "High school diploma or a high school equivalency certificate",
    cps19_education == "Professional degree or doctorate" ~ "University certificate, diploma or degree above the bach...", 
    cps19_education == "Completed technical, community college, CEGEP, College Classique" ~ "College, CEGEP or other non-university certificate or di...", 
    cps19_education == "Some university" ~ "Don't know"
  ))

# rename
reduced_data_survey <- reduced_data_survey %>% 
  rename(age = cps19_age)

reduced_data_survey <- reduced_data_survey %>% 
  rename(sex = cps19_gender)

reduced_data_survey <- reduced_data_survey %>% 
  rename(education = cps19_education)


write_csv(reduced_data_survey, "/Users/hyp/Desktop/304-final-project-main/survey_data.csv")
  
