rankall <- function(outcome, num = "best") {
        
        ## Check that state and outcome are valid
        outcomes <- c('heart attack', 'heart failure', 'pneumonia')
        
        if (!( outcome %in% outcomes)) 
        {
                stop(paste("Invalid outcome ",outcome))
        }
        
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
        
        ## Read outcome data
        data <- read.csv("C:/Project/DataScience/JHU/R/Plot_Assignment3-data/outcome-of-care-measures.csv",  colClasses = "character")
        
        result <- data.frame(matrix(ncol = 2, nrow = 0))
        colnames(result) <- c("hospital", "state")
        
        #unique state
        unique_state <- unique(data$State)
       
        for( state in unique_state)
        {
                data_state <- subset(data, State == state)
                
                if(num== "best")
                {
                        num = 0;
                }
                else if (num == "worst")
                {
                        num = nrow(data_state)
                }
                
                # sort on outcome
                data_state[,column] = suppressWarnings(as.numeric(data_state[,column]))
             
                data_state = data_state[!is.na(data_state[,column]),]
                
                data_sort = data_state[order(data_state[,column],data_state[,2]),]
               
                
                 result[nrow(result)+1,] <- list(data_sort[num,2],state)
                
                # rbind(result,c(data_sort[num,2],state))
        }
        
        return (result)
}