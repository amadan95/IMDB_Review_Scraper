library(rvest)
library(dplyr)
library(stringr)


#Scraping function for 100 records per movie/program

#Pulling Date, Rating, Title, and Review

#insert ID from IMDB Movie/TV Show URL excluding tt                                   


ID <- #######


Date <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                function(url){
                  url %>% read_html() %>% 
                    html_nodes(".review-date") %>% 
                    html_text() %>%
                    gsub('[\r\n\t]', '', .)
                  
                })

Stars <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                function(url){
                  url %>% read_html() %>% 
                    html_nodes(".rating-other-user-rating") %>% 
                    html_text() %>%
                    gsub('[\r\n\t]', '', .)
                  
                })

Title <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                function(url){
                  url %>% read_html() %>% 
                    html_nodes(".title") %>% 
                    html_text() %>%
                    gsub('[\r\n\t]', '', .)
                  
                })



Review <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                  function(url){
                    url %>% read_html() %>% 
                      html_nodes(".show-more__control") %>% 
                      html_text() %>%
                      gsub('[\r\n\t]', '', .)
                    
                  })

#Convert to Array

Date <- unlist(Date)
Title <- unlist(Title)
Stars <- unlist(Stars)
Review <- unlist(Review)

merge <- cbind(Date,Title,Stars,Review)


#Covert to Data Frame
Final_Table <- data.frame(merge,stringsAsFactors = FALSE)

#View Table
View(Final_Table)

#Export as CSV
write.csv(Final_Table,file='IMDB_Reviews.csv')



IMDB.All <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                    function(url){
                      url %>% read_html() %>% 
                        html_nodes(".review-date,.rating-other-user-rating,.title,.show-more__control") %>% 
                        html_text() %>%
                        gsub('[\r\n\t]', '', .)
                      
                    })
IMDB_Array <- unlist(IMDB.All)



r.1<- as.data.frame(split(IMDB_Array, 1:4))

