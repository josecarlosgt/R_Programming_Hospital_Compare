# Read outcome data
source("initialize.r")

# rankhospital(state, outcomeType, num = "best") 
# rankall that takes two arguments: an outcome name (outcome) and a hospital rank- ing (num).
# The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified in num.

rankall <- function(outcomeType, num = "best") {
  ## Check that num and outcome are valid
  if(!outcomeType %in% names(outcomeResolver)) {
    stop("Invalid outcome")
  }
  if(!num %in% c("best", "worst") && !is.numeric(num)) {
    stop("Invalid ranking number")
  }  
  outcomeCol <- outcomeResolver[outcomeType]
  
  rates <- outcome[!is.na(outcome[outcomeCol]), c("State", outcomeCol, "Hospital.Name")]
  rates[, 2] <- as.numeric(rates[, 2])
  
  ## For each state, find the hospital of the given rank
  numVal = 1
  decreasing = FALSE
  if(num == "worst") {
    decreasing = TRUE
  } else if (is.numeric(num)) {
    numVal = as.integer(num)
  } 
  orderedRates <- rates[order(rates$State, rates[outcomeCol], rates$Hospital.Name, decreasing = decreasing), ]
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  ratesByState <- split(orderedRates, orderedRates$State)
  lapply(ratesByState, function(elem) elem[numVal, "Hospital.Name"])
}

# Test
# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)
