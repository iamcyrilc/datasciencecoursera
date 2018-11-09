cor <- function(directory, threshold = 0)
{
        # Validate directory
        if(!dir.exists(directory))
        {
                return (paste("Invalid directory :", directory))
        }
        
        # inititlize
       
        cors <- numeric(0)
        id = c(1:332)
        
        for(i in id){
                # Fie Name
                createfilename = paste(str_pad(i,3,"left", pad = "0"),".csv", sep = "")
                filename <- file.path(directory,createfilename)
              
                # Read files
                cdata <- read.csv(filename)
              
                #Filter
                filter_data <- cdata[(!is.na(cdata$nitrate)),]
                filter_data <- filter_data[(!is.na(filter_data$sulfate)),]
              
                if( nrow(filter_data) >= threshold)
                {
                        cors <- c(cors, cor(as.character( filter_data["sulfate"]), as.character( filter_data["nitrate"])))
                }
               
        }
        
        cors  
}
