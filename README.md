# feelYourBodyHair

## Introduction
 
I set out to create a tool that changes how we interact with body hair, turning the often awkward conversation about body hair into a playful and artistic experience. With four modes - Pat, Care, Trim, and Dye - users can engage with virtual hair in different ways.
 
#### Pat Mode:
In this mode, users interact with their hair using their hands in front of the webcam. The video detects hand movements, and the virtual hair reacts as if it's being gently touched. This mode is designed to mimic the comforting feeling of running fingers through hair, with each stroke making the hair to sway and move softly.
 
#### Care Mode:
Here, the interaction shifts to the use of the mouse. Users can care for their hair by clicking and dragging the mouse over the hair, after which the hair will have less splits in its end. This mode resembles the effect of applying oil or conditioner.
 
#### Trim Mode:
Trim Mode brings the feeling of cutting and grooming. Users use their hand movements, captured through the webcam, to simulate trimming the hair. When the hair is touched by hand, it drops as if being cut.
 
#### Dye Mode:
Dye Mode is a playful exploration of color. Users select a dye color by holding a colored object close to the webcam. The tool then captures this color. As the user moves the mouse over the hair, it changes to the selected color, mimicking the process of dyeing hair.
 
Each mode is designed to offer a unique and interactive experience with virtual hair, allowing users to explore different aspects of hair interaction.
 

## Setup
 
Before using the tool, user needs to installed the OpenCV library for Processing(‘Sketch-import library-opencv’).
Then, move the hand.xml file which is included in the folder, and place it in the Processing libraries directory (…/Processing/libraries/opencv_processing/library/cascade-files/hand.xml).
 
After that, do the followings:
1. Open and run the sketch in Processing.
2. Read the description of each mode, then choose a mode by clicking on its button.
3. Note that you may need to wait for a few seconds to start the program.
4. Play with it!
5. Close the window to exit.
 
## Demo
![](https://github.com/enenmia/feelYourBodyHair/blob/main/feelYourBodyHairDemo.gif)

## Inflection: achievements and challenges
 
One of my proudest achievements in this project was successfully creating a space where body hair is celebrated and interacted with playfully. Integrating the webcam for real-time interaction in the Trim and Dye modes was particularly satisfying, as it brought an element of realism and user-friendliness to the user experience.
 
However, the journey has also faced many challenges. One significant challenge was controlling the hair’s behavior  after being interacted with, as I wanted to ensure it moved and reacted in a natural way.
 
Another challenge is that I chose to use a completely new library, OpenCV. It was daunting yet exciting. Learning to use it effectively by reading the documents online is a new experience for me, from which I learned the process of creating a program in real life: know what you want to do, search online, try to find what is necessary for you, and implement.
 
Perhaps the most challenging aspect was structuring the code. Initially, I worked on four separate sketches for each effect, which seemed manageable at first. However, merging them into a cohesive, well-structured set of classes and subclasses proved more challenging than I anticipated. This process was a true test of my coding skills and patience, but it was a valuable learning experience and helped me understand the intricacies of object-oriented programming.

