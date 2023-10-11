## Standard feed forward neural net

## TRAIN DATA
zero_columns <- apply(training_data, 2, function(col) all(col == 0))

# Remove columns with all zeros
training_data <- training_data[, !zero_columns]

training_data = as.data.frame(training_data)
x_train = training_data[,1:7801]


y_train = training_data[,7802]
y_train = as.factor(unlist(training_data$president_name))
y_train = as.integer(y_train) - 1
y_train = to_categorical(y_train)

#TEST DATA
## Standard feed forward neural net
zero_columns <- apply(test_data, 2, function(col) all(col == 0))

# Remove columns with all zeros
test_data <- test_data[, !zero_columns]

test_data = as.data.frame(test_data)
x_test = test_data[,1:7811]
## NEED TO REMOVE EMPTY COLUMS FROM GET GO


y_test = test_data[,7854]
y_test = as.factor(unlist(test_data$president_name))
y_test = as.integer(y_train) - 1
y_train = to_categorical(y_train)

library(keras)

model <- keras_model_sequential() %>%
  layer_dense(units = 32, input_shape = c(7811), activation = "relu") %>%
  layer_dense(units = 4, activation = "softmax")

summary(model)

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = "adam",
  metrics = "categorical_accuracy"
)

history <- model %>% fit(x_train, y_train, epochs = 50, batch_size = 2000, verbose = 0) 
plot(history)

results <- model %>% evaluate(test$x, test$y, batch_size=128, verbose = 2)

ts