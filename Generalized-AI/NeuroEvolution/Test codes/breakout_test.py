# -*- coding: utf-8 -*-
"""
Created on Sat Apr 13 12:39:02 2019

@author: Abhista
"""

import gym
import cv2

env = gym.make("Breakout-v0")

screen = env.reset()

done = False

while not done:
    env.render('human')
    screen = cv2.cvtColor(screen, cv2.COLOR_BGR2GRAY)
    screen = cv2.resize(screen[60:200,10:150], (int(140/5),int(140/5)))
    cv2.imshow('main', screen)
    screen,_, done,_ = env.step(env.action_space.sample())
env.close()