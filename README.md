# IE332Project2
# INTRO - One Pixel Attack
One Pixel Attack is a type of adversarial attack that can fool machine learning models by modifying a single pixel. 
Because only one percent of the pixels could be changed, one pixel is chosen since it only changes a single pixel. 
The algorithm uses an optimization process to find the pixel location and add it to the image. 
It is considered a powerful attack for its minimal changes, transferability, high success rate, and low computational cost. 
To create this algorithm, the objective function was defined; it takes the location of a pixel, model, image, and target class as inputs. 
This function generates a modified image with pixel location and sets it to zero. 
Then it reshapes the modified image to have a batch dimension of 1, predicts the class, and calculates the loss for the target class. 
The image is loaded then loaded and resized to 224 by 224 and scaled the pixel values between 0 and 1. 
Then it defines the search space and the bounds for such. 
After defining the target class and setting the optimization control parameters, it performs differential evolution with the DEoptim function which takes the objective function, model, image, target class, bounds, and control parameters as inputs. 
This function finds the best solution where it maximizes the loss which would be the best pixel location to modify. 
With the optimized pixel location, the color of the pixel is changed to red color and outputs a modified image that would fool the classifier. 

#Testing, Correctness, Verification
The One Pixel Algorithm was tested with multiple images to see if it fools the classifier. 
The algorithm was able to run, however, it took a long time when running DEoptim function, so we were not able to check if the modified image is fooling the classifier. 
In order to fix that, we have decreased the number of candidate solutions and max iterations. 
This, in fact, made the algorithm run very fast but was not capable of fooling the data. 
If batch processing or parallelization was used, theoretically it would successfully fool the data; it enables multiple computations to be performed simultaneously which would reduce the time without adjusting the number of iterations. 
Supposing everything worked without any error, the algorithm would be able to run the classifier with a single red pixel at the optimized location within a short period of time.

#Runtime and Walltime Complexity
This algorithm’s runtime complexity depends on the number of iterations and the search space. 
However, this algorithm took more than thirty minutes to run. 
It may be because it is looping through all pixels to find the optimized pixel location. 
Also, it may be because the DEoptim function has 50 candidate solutions and 1000 iterations which would be a total of 50000 function evaluations. 
Therefore the run time complexity would be O(NP*itermax*search space size*computation time per function evaluation). 
However, if batch or parallelization is used, it would have significantly decreased the time and hopefully takes less than 10 seconds

#Performace
The algorithm took more than thirty minutes to find the optimized pixel location, so it was uncertain to clarify if it was successful or not. 
There are a few factors that might have an impact on the running time. 
The optimization algorithm might be slow, and our codes might not be optimized for performance; because the optimization function runs through all the pixels in an image which would be 50,176 pixels (224 * 224). 
If batch processing or parallelization is used correctly, it will allow the system to run multiple computations simultaneously. 
As a result, the algorithm would be able to run through all pixels and find the optimized location, modify a single pixel, change color to red, and would be able to fool the classifier with the modified image.

#Justification
Since the constraint was to change only one percent of the pixels, this algorithm would suit the descriptions the best. 
This algorithm is modifying a single pixel which would be less than that of other adversarial attacks; it has a simpler concept. 
Also, using Differential Evolution helps find the best location, which also increases the probability of fooling the model. 
Not only does this algorithm have simplicity, but also the algorithm has a wide range of usages. 
According to a study by Devansh (2020), Differential Evolution is cheap, can be applied to almost any problem, and can be customized easily to match any constraints. 
Therefore, for such reasons, we have built this algorithm using Differential Evolution in order to fool the classifier which uses as few pixels as possible
