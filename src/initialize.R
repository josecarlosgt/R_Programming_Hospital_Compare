setwd("~/research/rep/R_Programming_Hospital_Compare/src")
outcome <- read.csv("../data/outcome-of-care-measures.csv", colClasses = "character")
# Outcomes:
#   11: Hospital 30-Day Death (Mortality) Rates from Heart Attack
#   17: Hospital 30-Day Death (Mortality) Rates from Heart Failure
#   23: Hospital 30-Day Death (Mortality) Rates from Pneumonia

outcomeResolver <- c("heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                     "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                     "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
