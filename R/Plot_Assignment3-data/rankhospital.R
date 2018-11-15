rankhospital <- function(state, outcome, num = "best") {
        
        ## Read outcome data
        data <- read.csv("C:/Project/DataScience/JHU/R/Plot_Assignment3-data/outcome-of-care-measures.csv",  colClasses = "character")
        
        
        ## Check that state and outcome are valid
        outcomes <- c('heart attack', 'heart failure', 'pneumonia')
        if ( !(state %in% data$State))
        {
                stop(paste("Invalid state ",state))
        }
        
        if (!( outcome %in% outcomes)) 
        {
                stop(paste("Invalid outcome ",outcome))
        }
        
        
        #Filter on state
        
        data_state <- subset(data, State == state)
        
        # outcome columns
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
        
        if(num== "best")
        {
                num = 0;
        }else if (num == "worst")
        {
                num = nrow(data_state)
        }
        
        # sort on outcome
        data_state[,column] = suppressWarnings(as.numeric(data_state[,column]))
        
        data_sort = data_state[order(data_state[,column],data_state[,2]),]
        
        return (data_sort[num,2])
      
}