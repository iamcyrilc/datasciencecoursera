#Assigment 1 - Calculate mean of pollutants
# Note some issues with first option. Need to review and fix
pollutantmean <- function(directory, pollutant, id = 1:332)
{
        
        # Validate directory
        if(!dir.exists(directory))
        {
                return (paste("Invalid directory :", directory))
        }
        
        # Validate pollutant
        if(length(pollutant) == 0)
        {
                return ("Invalid pollutant.")
        }
        
        # id has default value, so no need to validate
        
        # Loop through files and load data
        datafile= data.frame()
        for ( i in id)
        {
                # File names are three characters long in this example.
                # We may generalize it better if needed in future.
                createfilename = paste(str_pad(i,3,"left", pad = "0"),".csv", sep = "")
                filename <- file.path(directory,createfilename)
                
                
                # Read and append data files
               
                if(length(datafile) == 0)
                {
                        datafile = read.csv(filename, header = FALSE, stringsAsFactors = FALSE, check.names = TRUE,skip = 1)
                           
                }
                {
                        datafile <- rbind(datafile,read.csv(filename, header = FALSE, stringsAsFactors = FALSE))
                }
        }
    
        m=mean(datafile[pollutant], na.rm = TRUE)
        m
}



pollutantmean <- function(directory, pollutant, id = 1:332) {
      
        means <- c()
        
        for(i in id){
                createfilename = paste(str_pad(i,3,"left", pad = "0"),".csv", sep = "")
                filename <- file.path(directory,createfilename)
              
                cdata <- read.csv(filename)
                interested_data <- cdata[pollutant]
                means <- c(means, interested_data[!is.na(interested_data)])
        }
        
        mean(means)
}