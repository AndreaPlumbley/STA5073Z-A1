## Read in data and make bag of words


# Required libraries
library(dplyr)
library(tidyverse)
library(tidytext)
library(lubridate)
library(stringr)
library(rpart)


## Read the data in: code given. 

# read in text data files and organise these into a data frame
filenames <- c('1994_post_elections_Mandela.txt', '1994_pre_elections_deKlerk.txt', '1995_Mandela.txt', '1996_Mandela.txt', '1997_Mandela.txt', '1998_Mandela.txt', 
               '1999_post_elections_Mandela.txt', '1999_pre_elections_Mandela.txt', '2000_Mbeki.txt', '2001_Mbeki.txt', '2002_Mbeki.txt', '2003_Mbeki.txt', 
               '2004_post_elections_Mbeki.txt', '2004_pre_elections_Mbeki.txt', '2005_Mbeki.txt', '2006_Mbeki.txt', '2007_Mbeki.txt', '2008_Mbeki.txt', 
               '2009_post_elections_Zuma.txt', '2009_pre_elections_ Motlanthe.txt', '2010_Zuma.txt', '2011_Zuma.txt', '2012_Zuma.txt', '2013_Zuma.txt', 
               '2014_post_elections_Zuma.txt', '2014_pre_elections_Zuma.txt', '2015_Zuma.txt', '2016_Zuma.txt', '2017_Zuma.txt', '2018_Ramaphosa.txt', 
               '2019_post_elections_Ramaphosa.txt', '2019_pre_elections_Ramaphosa.txt', '2020_Ramaphosa.txt', '2021_Ramaphosa.txt', '2022_Ramaphosa.txt', '2023_Ramaphosa.txt')


this_speech <- c()
this_speech[1] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1994_post_elections_Mandela.txt', nchars = 27050)
this_speech[2] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1994_pre_elections_deKlerk.txt', nchars = 12786)
this_speech[3] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1995_Mandela.txt', nchars = 39019)
this_speech[4] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1996_Mandela.txt', nchars = 39524)
this_speech[5] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1997_Mandela.txt', nchars = 37489)
this_speech[6] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1998_Mandela.txt', nchars = 45247)
this_speech[7] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1999_post_elections_Mandela.txt', nchars = 34674)
this_speech[8] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/1999_pre_elections_Mandela.txt', nchars = 41225)
this_speech[9] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2000_Mbeki.txt', nchars = 37552)
this_speech[10] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2001_Mbeki.txt', nchars = 41719)
this_speech[11] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2002_Mbeki.txt', nchars = 50544)
this_speech[12] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2003_Mbeki.txt', nchars = 58284)
this_speech[13] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2004_post_elections_Mbeki.txt', nchars = 34590)
this_speech[14] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2004_pre_elections_Mbeki.txt', nchars = 39232)
this_speech[15] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2005_Mbeki.txt', nchars = 54635)
this_speech[16] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2006_Mbeki.txt', nchars = 48643)
this_speech[17] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2007_Mbeki.txt', nchars = 48641)
this_speech[18] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2008_Mbeki.txt', nchars = 44907)
this_speech[19] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2009_post_elections_Zuma.txt', nchars = 31101)
this_speech[20] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2009_pre_elections_Motlanthe.txt', nchars = 47157)
this_speech[21] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2010_Zuma.txt', nchars = 26384)
this_speech[22] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2011_Zuma.txt', nchars = 33281)
this_speech[23] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2012_Zuma.txt', nchars = 33376)
this_speech[24] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2013_Zuma.txt', nchars = 36006)
this_speech[25] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2014_post_elections_Zuma.txt', nchars = 29403)
this_speech[26] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2014_pre_elections_Zuma.txt', nchars = 36233)
this_speech[27] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2015_Zuma.txt', nchars = 32860)
this_speech[28] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2016_Zuma.txt', nchars = 32464)
this_speech[29] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2017_Zuma.txt', nchars = 35981)
this_speech[30] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2018_Ramaphosa.txt', nchars = 33290)
this_speech[31] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2019_post_elections_Ramaphosa.txt', nchars = 42112)
this_speech[32] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2019_pre_elections_Ramaphosa.txt', nchars = 56960)
this_speech[33] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2020_Ramaphosa.txt', nchars = 47910)
this_speech[34] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2021_Ramaphosa.txt', nchars = 43352)
this_speech[35] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2022_Ramaphosa.txt', nchars = 52972)
this_speech[36] <- readChar('https://raw.githubusercontent.com/iandurbach/datasci-fi/master/data/sona/2022_Ramaphosa.txt', nchars = 52972)

sona <- data.frame(filename = filenames, speech = this_speech, stringsAsFactors = FALSE)

# extract year and president for each speech
sona$year <- str_sub(sona$filename, start = 1, end = 4)
sona$president_13 <- str_remove_all(str_extract(sona$filename, "[dA-Z].*\\."), "\\.")

# clean the sona dataset by adding the date and removing unnecessary text
replace_reg <- '(http.*?(\\s|.$))|(www.*?(\\s|.$))|&amp;|&lt;|&gt;|\n'

sona <-sona %>%
  mutate(speech = str_replace_all(speech, replace_reg , ' ')
         ,date = str_sub(speech, start=1, end=30)
         ,date = str_replace_all(date, "February", "02")
         ,date = str_replace_all(date, "June", "06")
         ,date = str_replace_all(date, "Feb", "02")
         ,date = str_replace_all(date, "May", "05")
         ,date = str_replace_all(date, "Jun", "06")
         ,date = str_replace_all(date, "Thursday, ","")
         ,date = str_replace_all(date, ' ', '-')        
         ,date = str_replace_all(date, "[A-z]",'')
         ,date = str_replace_all(date, '-----', '')
         ,date = str_replace_all(date, '----', '')
         ,date = str_replace_all(date, '---', '')
         ,date = str_replace_all(date, '--', '')
  )

sona = sona[,2:5]

## Parse into sentences 
sona_sentences = unnest_tokens(sona, sentence, speech, token="sentences") %>%
  mutate(sentence_id = row_number()) %>% 
  rename(president_name = president_13)

#some cleaning
replace_reg = '(https?:.*?(\\s|.$))|(www.*?(\\s|.$))|&amp;|&lt;|&gt|\\*|\\(|\\)|\\"|\\“|\\”|\\¦|\\[|\\]|\\>|\\¬|\\.|\\�'

sona_sentences_cleaned = sona_sentences %>% 
  mutate(sentences =str_replace_all(sona_sentences$sentence, replace_reg, ''))  %>%
  select(-sentence)

sona_words = sona_sentences_cleaned %>% 
  unnest_tokens(word, sentences, token = "words")

## Need to still get rid of numbers and do some more cleaning

all_words = sona_words %>%
  group_by(word) %>%
  count() %>%
  ungroup()

all_words_cleaned = all_words %>%
                    filter(!str_detect(word, "\\d")) %>%
                    filter(str_length(word) > 2)

stopwords = stop_words$word
all_words_final = anti_join(all_words_cleaned, stop_words, by = "word")

sentence_word_links = sona_words %>%
  inner_join(all_words_final) %>%
  group_by(sentence_id, word) %>%
  count() %>%
  group_by(sentence_id) %>%
  mutate(total = sum(n)) %>%
  ungroup()

bag_of_words = sentence_word_links %>% 
  select(sentence_id, word, n) %>% 
  pivot_wider(names_from = word, values_from = n, values_fill = 0) %>%
  left_join(sona_sentences_cleaned %>% select(sentence_id, president_name)) %>%
  select(sentence_id, president_name, everything())


nrow(bag_of_words)


table(bag_of_words$president_name)


bag_of_words_4_pres = bag_of_words %>% 
  filter(president_name=="Mandela"|
           president_name=="Mbeki"|
           president_name=="Zuma"|
           president_name== "Ramaphosa")


table(bag_of_words_4_pres$president_name)

bag_of_words_4_pres = bag_of_words_4_pres %>%
  group_by(president_name) %>%
  slice_sample(n=1665)

table(bag_of_words_4_pres$president_name)

## Remove zero columns

zero_columns <- apply(bag_of_words_4_pres, 2, function(col) all(col == 0))

# Remove columns with all zeros
bag_of_words_final <- bag_of_words_4_pres[, !zero_columns]

#bag_of_words_grouped <- bag_of_words_4_pres %>%
# group_by(president_name) %>%
#slice(sample(n(), 200, replace = FALSE))

## Now to make training, validation and test sets. 
set.seed(2023)
training_ids = bag_of_words_final %>%
  group_by(president_name) %>%
  slice_sample(prop = 0.7) %>%
  ungroup() %>%
  select(sentence_id)

training_data <- bag_of_words_final %>% 
  right_join(training_ids, by = 'sentence_id') %>%
  select(-sentence_id)

test_data <- bag_of_words_final %>% 
  anti_join(training_ids, by = 'sentence_id') %>%
  select(-sentence_id)

fit <- rpart(president_name ~ ., training_data, method = 'class')

# options(repr.plot.width = 12, repr.plot.height = 10) # set plot size in the notebook
plot(fit, main = 'Full Classification Tree')
text(fit, use.n = TRUE, all = TRUE, cex=.8)

fittedtrain <- predict(fit, type = 'class')
predtrain <- table(training_data$president_name, fittedtrain)
predtrain
round(sum(diag(predtrain))/sum(predtrain), 3) # training accuracy

fittedtest <- predict(fit, newdata = test_data, type = 'class')
predtest <- table(test_data$president_name, fittedtest)
predtest
round(sum(diag(predtest))/sum(predtest), 3) # test accuracy


### ============ TFIDF ============

ndocs <- length(unique(sentence_word_links$sentence_id))

idf <- sentence_word_links%>% 
  group_by(word) %>% 
  summarize(docs_with_word = n()) %>% 
  ungroup() %>%
  mutate(idf = log(ndocs / docs_with_word)) %>% arrange(desc(idf))

sentence_tdf <- sentence_word_links%>% 
  left_join(idf, by = 'word') %>% 
  mutate(tf = n/total, tf_idf = tf * idf)

set.seed(2023)
random_sentence <- sample(sentence_tdf$sentence_id, 1)
sona_sentences %>% filter(sentence_id == random_sentence) %>% select(sentence)

sentence_tdf %>% filter(sentence_id == random_sentence) %>% arrange()

sentence_tdf <- sentence_tdf %>% 
  select(-idf, -tf, -tf_idf) %>% #remove the old ones we worked out
  bind_tf_idf(word, sentence_id, n)   #replace with values from tidytext

sentence_tdf %>% filter(sentence_id == random_sentence) %>% arrange() # check same as above


# TREE with TFIDF 
## CHECK if deklerk and mothahle words are here 

tfidf <- sentence_tdf %>% 
  select(sentence_id, word, tf_idf) %>%  # note the change, using tf-idf
  pivot_wider(names_from = word, values_from = tf_idf, values_fill = 0) %>%  
  left_join(sona_sentences_cleaned %>% select(sentence_id,president_name))

zero_columns <- apply(tfidf, 2, function(col) all(col == 0))

# Remove columns with all zeros
tfidf <- tfidf[, !zero_columns]

training_data <- tfidf %>% 
  right_join(training_ids, by = 'sentence_id') %>%
  select(-sentence_id)

test_data <- tfidf %>% 
  anti_join(training_ids, by = 'sentence_id') %>%
  select(-sentence_id)

fit <- rpart(factor(president_name) ~ ., training_data)

# options(repr.plot.width = 12, repr.plot.height = 10) # set plot size in the notebook
plot(fit, main='Full Classification Tree')
text(fit, use.n=TRUE, all=TRUE, cex=.8)


fittedtrain <- predict(fit, type = 'class')
predtrain <- table(training_data$president_name, fittedtrain)
predtrain
round(sum(diag(predtrain))/sum(predtrain), 3) # training accuracy

fittedtest <- predict(fit,newdata=test_data,type='class')
predtest <- table(test_data$president_name,fittedtest)
predtest
round(sum(diag(predtest))/sum(predtest), 3) # test accuracy




