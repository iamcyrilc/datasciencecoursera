
complete  <- function(directory, id = 1:332) {
  # count of all records where both sulfate and ntrate are NA   
        
        
        # Validate directory
        if(!dir.exists(directory))
        {
                return (paste("Invalid directory :", directory))
        }
        
        #inititlize
        total = data.frame(id = numeric(0), nobs = numeric(0))
        
        
        for(i in id){
                # Fie Name
                createfilename = paste(str_pad(i,3,"left", pad = "0"),".csv", sep = "")
                filename <- file.path(directory,createfilename)
               
                # Read files
                cdata <- read.csv(filename)
               
                #Filter
                filter_data <- cdata[(!is.na(cdata$nitrate)),]
                filter_data <- filter_data[(!is.na(filter_data$sulfate)),]
                
                total = rbind(total, data.frame(id = id, nobs = nrow(filter_data)))
        }
        
        total
}