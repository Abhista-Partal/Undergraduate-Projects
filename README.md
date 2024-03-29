# Undergraduate-Projects
Each project I've undertaken has been stored in the folder named by that specific project.

# 1) Generalized AI (General code for different environments!)
This folder contains the first two stages of my undergraduate project.
   #### a) The first stage is stored in the folder named DeepQLearning.
   This folder contains the model.py file and the main.py file. The model.py file contains the code of the 
   DeepQLearning algorithm implemented using the PyTorch python package.
   The main.py is the instantiation of DeepQ model. Running this file produces the tmp folders containing 
   the run for each iteration. The tmp500 file contains 500 video files representing the agent playing in 
   the SpaceInvaders Environment. We can see that the agent improves over time as the score for each iteration 
   on average increases.
   
   #### b) The second stage is stored in the folder named Neurovolution.
   This folder contains all the python files and pkl memory files used to run the Neuroevolution algorithm 
   from a pretrained state. Running the *GUI.py* file creates a minimalist Graphic User Interface for the user to run the different
   codes and check the results of the NeuroEvolution algorithm. The algorithm is tested on three OpenAI gym environments :-
   ###### 1. CartPole Balancing.
   ###### 2. MountainCar.
   ###### 3. SpaceInvaders.
   
   Each of them has an option to train a new neural network or use the pretrained network to test the results.
   The SpaceInvaders environment instead has the option to play the game to see the difficulty the agent faces in 
   learning the game.
   
# 2) MATLAB Implementation of Neural Networks
This folder contains all the programs implementing different Neural Networks written in matlab without using any packages.
   ###### 1. The perceptron_____.m codes show visualizations of how a basic perceptron Neural Network model classifies data in 1, 2
   ###### and 3 features for classification respectively.
   ###### 2. The RBF Neural Network is a simplification for the non-linear function reproduced by the hidden layers of the network. The
   ###### code is written in the RBFcircle.m file where the datasets classification boundary is a circle.
   ###### 3. The BackPropagation algorithm is implemented for a single hidden layer Neural Network in the BackProp.m file to classify
   ###### for the same dataset used for the classification of the RBF Neural Network.
