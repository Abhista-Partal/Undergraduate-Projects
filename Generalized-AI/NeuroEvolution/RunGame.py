# -*- coding: utf-8 -*-
"""
Created on Tue Apr  2 17:56:37 2019

@author: Abhista
"""

import neat, gym, pickle, cv2
import numpy as np

enviroment = ['Breakout-v0', 'SpaceInvaders-v0']
AI = ['Breakout_AI', 'SpaceInvaders_AI']
config_file = ['config-Breakout', 'config-SpaceInvaders']

env = gym.make(enviroment[1])
with open(AI[1] + '.pkl', 'rb') as file:
    genome = pickle.load(file)    
config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction,
                     neat.DefaultSpeciesSet, neat.DefaultStagnation,
                     config_file[1])
net = neat.nn.FeedForwardNetwork.create(genome, config)
done = False
screen = env.reset()
while not done:
    env.render('human')
    screen = cv2.cvtColor(screen, cv2.COLOR_BGR2GRAY)
    screen = cv2.resize(screen[15:200,30:125], (int(185/2.5), int(95/2.5)))
    screen_inp = [y for x in screen for y in x]
    action = net.activate(screen_inp)
    action = np.argmax(action)
    print(action)
    screen, reward, done, info = env.step(action)
env.close()