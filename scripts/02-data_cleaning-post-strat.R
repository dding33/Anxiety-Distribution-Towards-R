#### Preamble ####
# Purpose: Simulate student census and prepare cell counts for post-stratification.
# Author: Yiqu Ding
# Data: 11 December 2020
# Contact: yiqu.ding@mail.utoronto.ca
# License: MIT
# Notes:
# 1. For categorical variables, make sure the name of each level of the variable
# match between the sample data and your post-strat data. For example, if you 
# lable sex by "F" and "M" in your sample data set, you must label your 
# post-strat sex variable using "F" and "M" as well. 

#### Workspace setup ####
library(tidyverse)
library(haven)
library(dplyr)

# 1.Simulate a student census.

# Use a seed to stabilize the sampling results.
set.seed(3329)

# We will start by creating vectors for each variables.

student_id <- c(1:850)
sex <- sample(c("Female", "Male"), size = 850, replace = TRUE)

# Create the program variable

program_list <- c(
  "Statistics Minor", "Statistics Major",
  "Applied Statistics Specialist", "Statistics Methods and Practice Specialist",
  "Statistics Theory and Methods Specialist",
  "Data Science Specialist", "Actuarial Science Major", "Actuarial Science Specialist"
  ) #Create list of programs
program_dist <- c(0.2, 0.5, 0.025, 0.05, 0.05, 0.05, 0.1, 0.025)#A list indicating distribution of programs
program <- sample(program_list, size = 850, prob = program_dist, replace = TRUE)

# Create the cgpa variable

cgpa_list <- c("A (3.4 to 4.0)", "B (2.4 to 3.3)", "C (1.4 to 2.3)", "D (0.7 to 1.3)", "F (0.0 to 0.6)")
cgpa_dist <- c (0.1, 0.3, 0.34, 0.25, 0.01)
cgpa <- sample(cgpa_list, size = 850, prob = cgpa_dist, replace = TRUE)

# Create coding experience variable
coding_exp <- sample(c("Yes", "No"), size = 850, prob = c(0.85, 0.15), replace = TRUE)

#Combine the variables into a data frame

census <- data.frame(
  cbind(student_id, sex, program, cgpa, coding_exp)
)

# 2. Calculate counts and proportions from the census to post-stratify on

# Calculate cell counts and save

cell_counts <- census %>% 
  group_by(sex, program, cgpa, coding_exp) %>% 
  count() %>% 
  mutate(proportion = n/850)

# I also want to create proportions for each variables

sex_prop <- cell_counts %>% 
  ungroup() %>% 
  group_by(sex) %>% 
  mutate(prop = n/sum(n)) %>% 
  ungroup()

program_prop <- cell_counts %>% 
  ungroup() %>% 
  group_by(program) %>% 
  mutate(prop = n/sum(n)) %>% 
  ungroup()

cgpa_prop <- cell_counts %>% 
  ungroup() %>% 
  group_by(cgpa) %>% 
  mutate(prop = n/sum(n)) %>% 
  ungroup()

code_prop <- cell_counts %>% 
  ungroup() %>% 
  group_by(coding_exp) %>% 
  mutate(prop = n/sum(n)) %>% 
  ungroup()

# I need to export the data frame to use them in paper.Rmd. They will be saved under the data folder.

write.csv(census, file = "census.csv")
write.csv(cell_counts, file = "cell_counts.csv")
write.csv(sex_prop, file = "sex_prop.csv")
write.csv(program_prop, file = "program_prop.csv")
write.csv(cgpa_prop, file = "cgpa_prop.csv")
write.csv(code_prop, file = "code_prop.csv")

