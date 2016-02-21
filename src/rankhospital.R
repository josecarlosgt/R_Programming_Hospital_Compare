# Read outcome data
source("initialize.r")

# rankhospital(state, outcomeType, num = "best") 
# Takes three arguments: the 2-character abbreviated name of a state (state), an outcome (outcome), 
# and the ranking of a hospital in that state for that outcome (num). The function reads the 
# outcome-of-care-measures.csv file and returns a character vector with the name of the hospital
# that has the ranking specified by the num argument.

rankhospital <- function(state, outcomeType, num = "best") {
  ## Check that state, outcome and num are valid
  if (!state %in% outcome$State) {
    stop("Invalid state")
  } else if(!outcomeType %in% names(outcomeResolver)) {
    stop("Invalid outcome")
  } else if(!num %in% c("best", "worst") && !is.numeric(num)) {
    stop("Invalid ranking number")
  }  
  outcomeCol <- outcomeResolver[outcomeType]
  
  rate <- outcome[outcome$State == state & !is.na(outcome[outcomeCol]), c(outcomeCol, "Hospital.Name")]
  rate[, 1] <- as.numeric(rate[, 1])
  
  ## Sort hospital name in that state by 30-day death rate
  numVal = 1
  decreasing = FALSE
  if(num == "worst") {
    decreasing = TRUE
  } else if(is.numeric(num)) {
    numVal = as.integer(num)
    if(numVal > nrow(rate)) {
      
      return (NA)
    }
  } 
  orderedRate <- rate[order(rate[outcomeCol], rate$Hospital.Name, decreasing = decreasing), ]
  orderedRate[numVal,]$Hospital.Name
}

# Test
# rankhospital("MD", "heart attack", "worst") 
# rankhospital("TX", "heart failure", 4)
# rankhospital("MN", "heart attack", 5000)
