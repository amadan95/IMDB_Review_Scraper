library(rvest)
library(dplyr)
library(stringr)
library(tidyverse)
library(janitor)

ID <- # IMDB ID 

data <- lapply(paste0('http://www.imdb.com/title/tt', ID, '/reviews?filter=prolific', 1:100),
                   function(url){
                     url %>% read_html() %>% 
                       html_nodes(".review-date,.rating-other-user-rating,.title,.show-more__control") %>% 
                       html_text() %>%
                       gsub('[\r\n\t]', '', .)
                   })

data.df <- data.frame(data)
colnames(data.df)[1] <- 'col1'

data.df %>% remove_empty("rows")

text_data = gsub('\\b(\\d+/\\d+)\\b','\n\\1',paste(grep('\\w',data.df$col1,value = TRUE),collapse = ':')) 
final <- read.csv(text=text_data,h=F,sep=":",strip.white = T,fill=T,stringsAsFactors = F)

names(data) <- c("Rating", "Title","Date","Review")


#Export as CSV
write.csv(final ,file='IMDB_Reviews.csv')
