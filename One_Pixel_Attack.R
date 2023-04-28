library(imager)
library(keras)
library(EBImage)
library(DEoptim)
# Load the pre-trained model
model <- load_model_tf("./dandelion_model")

# Define the objective function to maximize
objective_function <- function(pixel_location, model, test_image, target_class) {
  # Generate modified image with pixel location
  modified_image <- test_image
  modified_image[pixel_location[1], pixel_location[2], ] <- 1
  # Reshape the modified image to have a dimension of 1
  modified_image <- array_reshape(modified_image, c(1, 224, 224, 3))
  # Predict the class probabilities of the modified image
  probs <- model %>% predict(modified_image)
  # Calculate the loss for the target and true classes
  target_loss <- -log(probs[1, target_class])
  true_class <- which.max(probs)
  true_loss <- -log(probs[1, true_class])
  # Maximize the difference
  loss <- target_loss - true_los
  return(-loss) #eturn loss
}

# Load the test image
original_image <- image_load("test/grass/th-4166387598.jpg", target_size = c(224, 224))
x <- image_to_array(original_image)
x <- x / 255

# Define the search space
search_space <- array(dim = c(224, 224, 2))
for (i in 1:224) {
  for (j in 1:224) {
    search_space[i,j,1] <- i
    search_space[i,j,2] <- j
  }
}
# Define the bounds for the search space
lower_bound <- c(1, 1)
upper_bound <- c(224, 224)

# Define the optimization control parameters
control_params <- list(NP = 50, itermax = 100, F = 0.8, CR = 0.9)

# Define the target class
target_class <- 1

# Perform differential evolution
result <- DEoptim(fn = objective_function, model = model, test_image = x, target_class = target_class,
                  lower = lower_bound, upper = upper_bound, control = control_params)

# Extract the best solution and its pixel location
best_solution <- result$optim$bestmem
pixel_location <- floor(as.integer(best_solution))

# Apply the pixel solution to generate a modified image
modified_image <- array_reshape(x, dim(x))

# Set the pixel value at the identified location to white color
modified_image[pixel_location[1], pixel_location[2],] <- c(1, 0.5, 0)

# Reshape the modified image back to its original shape
modified_image <- array_reshape(modified_image, c(1, dim(modified_image)))

# Reshape the modified image to have a batch dimension of 1
modified_image <- array_reshape(modified_image, c(1, 224, 224, 3))

# Run the prediction on the modified image
pred <- model %>% predict(modified_image)
print(pred)



