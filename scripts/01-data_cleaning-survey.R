#### Preamble ####
# Purpose: Prepare and clean the survey data obtained from a survey conducted through Google Forms by Yiqu Ding.
# Author: Yiqu Ding
# Data: 12 December 2020
# Contact: yiqu.ding@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - You need to send an email to the contact email to obtain the data.
# But the clean_data.csv under inputs->data should be sufficient to reproduce this analysis.

#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data 
raw_data <- read.csv("survey_results.csv")# Remember to set this to where the result is.
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Rename the variables
renamed_data <- 
  raw_data %>% 
  rename(
    qualification = Are.you.a.third.year.student.at.the.University.of.Toronto.and.enrolled.in.a.stats.related.program.,
    program = What.is.the.name.of.the.program.that.you.are.enrolled.in.,
    sex = What.is.your.gender.,
    coding_exp =  Do.you.have.experience.with.any.other.programming.languages.except.for.R.,
    cgpa = What.is.your.cGPA.at.the.time.of.the.survey.,
    anxiety_score = If.you.were.asked.to.independently.complete.a.data.analysis.using.R..how.do.you.feel..,
    suggestion = What.would.ease.your.worries.about.R.
  )
#Keep only part of the variables
reduced_data <- 
  renamed_data %>% 
  select(
    qualification, program, sex, coding_exp, cgpa, anxiety_score
  )
#Only keep responses who answered 'yes' to the qualification question
reduced_data <- na.omit(reduced_data)
#We no longer need the qualification question
final_data <- 
  reduced_data %>% 
  select(program, sex, coding_exp, cgpa, anxiety_score)

#Export the cleaned data
write.csv(final_data, file = "clean_data.csv")

