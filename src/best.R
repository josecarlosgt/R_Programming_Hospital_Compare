## Read outcome data
source("initialize.r")

# best(state, outcomeType)
# returns a character vector with the name of the hospital that has the best (i.e. lowest)
# 30-day mortality for the specified outcome in that state.
# Outcomes:
#   11: Hospital 30-Day Death (Mortality) Rates from Heart Attack
#   17: Hospital 30-Day Death (Mortality) Rates from Heart Failure
#   23: Hospital 30-Day Death (Mortality) Rates from Pneumonia
best <- function(state, outcomeType) {
  outcomeResolver <- c("heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                       "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                       "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  outcomeCol <- outcomeResolver[outcomeType]
  
  ## Check that state and outcome are valid
  if (!state %in% outcome$State) {
    stop("Invalid state")
  } else if(!outcomeType %in% names(outcomeResolver)) {
    stop("Invalid outcome")
  }
  
  rate <- outcome[outcome$State == state & !is.na(outcome[outcomeCol]), c(outcomeCol, "Hospital.Name")]
  rate[, 1] <- as.numeric(rate[, 1])
    
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  orderedRate <- rate[order(rate[outcomeCol], rate$Hospital.Name), ]
  orderedRate[1,]$Hospital.Name
}
