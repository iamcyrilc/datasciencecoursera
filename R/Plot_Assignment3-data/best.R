best <- function( state, outcome)
{
        #Possible outcome
        outcomes <- c('heart attack', 'heart failure', 'pneumonia')
        
        # Read outcome data
        outcomedata <- read.csv("C:/Project/DataScience/JHU/R/Plot_Assignment3-data/outcome-of-care-measures.csv",  colClasses = "character")
       
        # validate input
        if ( !(state %in% outcomedata$State))
        {
                stop(paste("Invalid state ",state))
        }
        
        if (!( outcome %in% outcomes)) # outcomedata$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        {
                stop(paste("Invalid outcome ",outcome))
        }
        
        # filter on state
        outcomeState <- subset(outcomedata, State == state )
       
        # outcome column name
        if (outcome == "heart attack") {
                column <- 11
        }
        else if (outcome == "heart failure") {
                column <- 17
        }
        else {
                column <- 23
        }
        
        # filter outcome
        minMortatlity <-suppressWarnings( which(as.numeric(outcomeState[ ,column]) == 
                                 min(as.numeric(outcomeState[ ,column]), na.rm = TRUE)))
        
        hospitals <- outcomeState[minMortatlity,2]
        hospitals <- sort(hospitals)
        return(hospitals[1])
}