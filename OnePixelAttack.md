# IE332Project2
# INTRO - One Pixel Attack

One Pixel Attack is a form of adversarial attack that uses a single modified pixel to fool the classifier. 
Since it only changes one pixel, it fits under the one percent pixel constraint. 
The algorithm finds the pixel location and adds it to the image using an optimization technique. Because of its few modifications, transferability, high success rate, and low computational cost, it is regarded as a powerful attack. 
To develop this algorithm, the objective function which requires the location of pixel, model, image, and target class as inputs, was defined. 
This function creates a modified image with pixel position and sets it to zero. 
The updated image is then reshaped to have a batch dimension of 1, the class is predicted, and the loss for the intended class is calculated. 
The image is then loaded, enlarged to 224 by 224 pixels, then scaled so that the pixel values range from 0 to 1. The search space and its bounds are then defined. 
The DEoptim function, which accepts the objective function, model, picture, target class, bounds, and control parameters as inputs, is used to perform differential evolution after defining the target class and specifying the optimization control parameters. This function finds the best solution where it maximizes the loss which would be the best pixel location to alter. With the optimized pixel location, the color of the pixel is changed to red color and outputs a modified image that would fool the classifier. 
<br> 

#Testing, Correctness, Verification
<br> 
The One Pixel Algorithm was tested with multiple images to see if it fools the classifier. 
The algorithm was able to run, however, it took a long time when running DEoptim function, so we were not able to check if the modified image is fooling the classifier. 
In order to fix that, we have decreased the number of candidate solutions and max iterations. 
This, in fact, made the algorithm run very fast but was not capable of fooling the data. 
If batch processing or parallelization was used, theoretically it would successfully fool the data; it enables multiple computations to be performed simultaneously which would reduce the time without adjusting the number of iterations. 
Supposing everything worked without any error, the algorithm would be able to run the classifier with a single red pixel at the optimized location within a short period of time.
<br> 

#Runtime and Walltime Complexity<br> 
This algorithm’s runtime complexity depends on the number of iterations and the search space. 
However, this algorithm took more than thirty minutes to run. 
It may be because it is looping through all pixels to find the optimized pixel location. 
Also, it may be because the DEoptim function has 50 candidate solutions and 1000 iterations which would be a total of 50000 function evaluations. 
Therefore the run time complexity would be O(NP*itermax*search space size*computation time per function evaluation). 
However, if batch or parallelization is used, it would have significantly decreased the time and hopefully takes less than 10 seconds
<br> 

#Performace<br> 
The algorithm took more than thirty minutes to find the optimized pixel location, so it was uncertain to clarify if it was successful or not. 
There are a few factors that might have an impact on the running time. 
The optimization algorithm might be slow, and our codes might not be optimized for performance; because the optimization function runs through all the pixels in an image which would be 50,176 pixels (224 * 224). 
If batch processing or parallelization is used correctly, it will allow the system to run multiple computations simultaneously. 
As a result, the algorithm would be able to run through all pixels and find the optimized location, modify a single pixel, change color to red, and would be able to fool the classifier with the modified image.

#Justification<br> 
Since only one percent of the pixels could be modified, the one pixel attack would work the best; it only modifies a single pixel, which is much fewer pixels than that of other adversarial attacks.  
This notion is by far the simplest among other attacks. Also, using differential evolution allows us to find the best location of a pixel to be altered, which would result in a higher chance of fooling the classifier. Moreover, a study by Devansh (2020) claims that the one pixel attack algorithm can be widely used; it could be used for almost any problem by customizing it to meet any constraint. 
For such reasons, we believe that one pixel algorithm using differential evolution would be suitable for fooling the model.
