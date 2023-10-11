## RANDOM FOREST 


library(ranger)

president_factor = as.factor(training_data$president_name)

rf_model <- ranger(
  formula = president_factor ~ .,  # Assuming 'president' is the response variable
  data = as_tibble(training_data[,-1]),
  num.trees = 500,  # Adjust the number of trees as needed
  importance = "permutation",  # Calculate variable importance
  seed = 2023  # Set seed for reproducibility
)

# Make predictions on the test set
predictions <- predict(rf_model, data = test_data)$predictions

# Evaluate the accuracy
accuracy <- sum(predictions == test_data$president) / nrow(test_data)
cat("Test Accuracy: ", accuracy, "\n")

# Variable importance plot
var_importance <- importance(rf_model)
plot(var_importance)