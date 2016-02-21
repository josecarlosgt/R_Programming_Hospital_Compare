# Read outcome data
source("initialize.r")

# best(state, outcomeType)
# returns a character vector with the name of the hospital that has the best (i.e. lowest)
# 30-day mortality for the specified outcome in that state.

best <- function(state, outcomeType) {
  ## Check that state and outcome are valid
  if (!state %in% outcome$State) {
    stop("Invalid state")
  } else if(!outcomeType %in% names(outcomeResolver)) {
    stop("Invalid outcome")
  }
  outcomeCol <- outcomeResolver[outcomeType]
  
  rate <- outcome[outcome$State == state & !is.na(outcome[outcomeCol]), c(outcomeCol, "Hospital.Name")]
  rate[, 1] <- as.numeric(rate[, 1])
    
  ## Sort hospital name in that state by 30-day death rate (increasingly)
  orderedRate <- rate[order(rate[outcomeCol], rate$Hospital.Name), ]
  orderedRate[1,]$Hospital.Name
}

# Test
# best("TX", "heart attack")
# best("TX", "heart failure")
# best("MD", "heart attack")
# best("MD", "pneumonia")
# best("MD", "pneumonia")
# best("NY", "hert attack")
