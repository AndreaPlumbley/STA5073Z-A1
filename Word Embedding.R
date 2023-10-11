## Word embeddings
library(readr)
library(stringr)
library(lubridate)
library(tidytext)
library(keras)

max_features <- 1000        # choose max_features most popular words
tokenizer = text_tokenizer(num_words = max_features)

fit_text_tokenizer(tokenizer, sona_sentences$sentence)

sona_sentences$sentence[1]
tts <- texts_to_sequences(tokenizer, sona_sentences$sentence[1])
tts
tokenizer$word_index[tts[[1]]]
sequences = tokenizer$texts_to_sequences(sona_sentences$sentence)
