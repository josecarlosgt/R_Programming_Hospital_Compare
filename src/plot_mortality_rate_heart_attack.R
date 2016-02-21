# Histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset)

source("initialize.r")

outcome[, 11] <- as.numeric(outcome[, 11])

# You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])
