#HILL CLIMB ATTACK FINAL

#load libraries
library(jpeg)
setwd("C:/Users/Mason/OneDrive/Documents/data-for-332/training/grass")

# input the image
image_path <- "./Dry-Autumn-Leaf-on-Green-Grass-3292439640.jpg"
img <- readJPEG(image_path)

# Define the objective function
objective_function <- function(image, target_class, model) {
  prediction <- predict(model, image)
  return(prediction[target_class])
}

# Define the hill climbing function
hill_climbing <- function(image, target_class, model, max_iter = 100, step_size = 0.01) {
  current_image <- image
  current_score <- objective_function(current_image, target_class, model)
  for (i in 1:max_iter) {
    
    # Perturb the image by adding noise
   
    # Function to randomly change color of pixels in an image
    change_pixel_color <- function(img, num_pixels) {
      for (i in 1:num_pixels) {
        # Generate random pixel coordinates
        x <- sample(1:dim(img)[1], 1)
        y <- sample(1:dim(img)[2], 1)
        
        # Generate random color values
        r <- runif(1)
        g <- runif(1)
        b <- runif(1)
        
        # Update pixel color
        img[x, y, 1] <- r
        img[x, y, 2] <- g
        img[x, y, 3] <- b
      }
      return(img)
    
    
    # Evaluate the objective function for the perturbed image
    perturbed_score <- objective_function(perturbed_image, target_class, model)
    
    # If the score improved, update the current image
    if (perturbed_score > current_score) {
      current_image <- perturbed_image
      current_score <- perturbed_score
    }
  }
  }
  return(current_image)
}


# Perform the hill climbing attack
target_class <- 7
current_image <- hill_climbing(img, target_class, model, max_iter = 100, step_size = 0.01)

#test
pred <- model %>% predict(current_image)

#save perturbed image
writeJPEG(adversarial_image, "C:/Users/Mason/OneDrive/Documents/data-for-332/perturbed/grass")
