library(rvest)
library(dplyr)
library(stringr)


#Scraping function for 100 records per movie/program

#Pulling Date, Rating, Title, and Review

#insert ID from IMDB Movie/TV Show URL excluding tt                                   


ID <- #######



IMDB.All <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:10),
                    function(url){
                      url %>% read_html() %>% 
                        html_nodes(".review-date,.rating-other-user-rating,.title,.show-more__control") %>% 
                        html_text() %>%
                        gsub('[\r\n\t]', '', .)
                      
                    })
IMDB_Array <- unlist(IMDB.All)


#Export as CSV
write.csv(Final_Table,file='IMDB_Reviews.csv')



