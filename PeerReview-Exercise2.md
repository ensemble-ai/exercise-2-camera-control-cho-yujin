# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Eugene Cho
* *email:* eacho@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The stage works perfectly, and is implemented correctly. The cross is drawn well, and the camera locks onto the position of the vessel
___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The autoscroller works properly, and the player is not able to move in any area other than the box. The logic is implemented super concisely and efficiently
With that said, this stage could be improved by using the width/height of the vessel to properly block the edge from going over the edge instead of the center of the vessel
Additionally the exported fields are implemented properly, and are visible to change on the outside.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock with lerp smoothing works perfectly. The camera follows slightly behind the player, and when it stops it will follow the player at the catchupspeed
After changing the different values of the catchup speed and the follow speed, the implementation works poperly with the following and smoothing
Additionally, the drawlogic functionality is correct, with a cross as well as an additional dashed-circle to represent the leash distance.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The leading camera with lerp smoothing works perfectly. The camera leads the player, and the fields for leash, catchup speed, leading speed, and delay all work properly
Additionally, the leash distance has also been visualized for the vessel, and when zooming it is properly leashed. When all the fields are changed, it will affect the functionality of the camera as well, which is good
While there are some stutters on my device, I believe it is more to deal with the overall game performance rather than how the exercise was implemented.

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The basic functionality of the four way push zone is sound. There is an outerborder that will match the players speed when pushed
There is an inner box where there is no player movement, and there is a speedup zone where the camera will move at a fraction of the vessels movement. However, I feel that the implementation feels a little bit off, and my attempts at changing the fraction of the movement behave a little bit differently than I expected. However functionally, it works as the exercise requires
The implementation is additionally inconsistent with dealing with different fields, as the zone is determined in one singular if statement instead of different if statements which lead to a little bit of inconsistency.

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
Overall, the style guide is followed for the most part throughout the project. The implementations are clean and commented, and for the most part this exercise did not require as much opportunity to showcase style guide because it was more focused on individual cameras and typically manipulation of a single process() function in most cases. However, I discovered a couple issues with regard to code styles
https://github.com/ensemble-ai/exercise-2-camera-control-cho-yujin/blob/7f0cf93764aa9c993502e1b9fc4b3af9eb42e9ab/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L24
Here, the variable's name could be changed to something more descriptive, as well as no need to declare a type when the variable is immediately being assigned after.
This style guide infraction is quite common among the majority of the stage's implementations, and by fixing this infracion the code can look neater and more readable.


#### Style Guide Exemplars ####
The code is overall very well formatted with proper posiitioning of private variables 
One example is https://github.com/ensemble-ai/exercise-2-camera-control-cho-yujin/blob/7f0cf93764aa9c993502e1b9fc4b3af9eb42e9ab/Obscura/scripts/camera_controllers/lerp_smoothing_target_focus.gd#L9
where the private variables are properly declared underneath the exported variables, which are good examples of following the godot code style.
___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
There are a couple best practices infractions that I noticed. One big one is in stage 5
https://github.com/ensemble-ai/exercise-2-camera-control-cho-yujin/blob/7f0cf93764aa9c993502e1b9fc4b3af9eb42e9ab/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L32
where the implementation used an if statement that spanned across four lines. This in general is bad practice, because it is unhelpful for detecting issues, and additionally is inconsistent with precise movements from the vessel. I believe that if an implementation was done with different if statements it would have been more consistent. Additionally, two lines above the variables for the function were declared and only used in that if statement. Perhaps implementing it as a class variable and using them again in the draw_logic function could be better in practice.
Another notable best practice infraction (I'm not going to link because it is present in almost every exercise) is the usage of direct .position usage instead of perhaps setting a variable like cpos or tpos in the example pushbox. This would help keep the code more concise and clean, especially for implementations where these variables are accessed many many times. 
Finally, the last notable infraction I noticed was where many of the implementations did not include the vessel height or width to get the exact position for checking borders. One example is https://github.com/ensemble-ai/exercise-2-camera-control-cho-yujin/blob/7f0cf93764aa9c993502e1b9fc4b3af9eb42e9ab/Obscura/scripts/camera_controllers/horizontal_auto_scroll.gd#L29
where the implementation does not include the outer edge of the vessel. While this does not necessarily change the functionality of the code, it is helpful for proper code implementations, and in projects where the code becomes more complex, it is good to maintain proper hitboxes and locations of the player.


#### Best Practices Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-cho-yujin/blob/7f0cf93764aa9c993502e1b9fc4b3af9eb42e9ab/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L72
One best practice I noticed was the inclusion of the leash distance in drawlogic of the project. Having the additional circle to determine the leash distance is helpful for debugging and visualization
There are also many comments as well as many different commits, which are examples of good practice as well as being helpful to follow the code.
Finally, many of the functions are implemented efficiently, and generally speaking many of the implementations are consise and don't have a lot of random variables or difficult to understand values/names