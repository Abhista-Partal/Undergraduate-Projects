# -*- coding: utf-8 -*-
"""
Created on Sun Mar 31 19:05:21 2019

@author: Abhista
"""

import gym
from gym import wrappers
from torch import argmax
import numpy as np
import cv2
import neat
import pickle


class Worker(object):
    def __init__(self, genome, config):
        self.genome = genome
        self.config = config
        
    def work(self):
        self.env = gym.make('SpaceInvaders-v0')
        env = wrappers.Monitor(self.env, "tmp50-Neuro/space-invaders-1", video_callable=lambda episode_id: True, force=True)
        screen = env.reset()
        in_x, in_y, in_c = env.observation_space.shape
        net = neat.nn.FeedForwardNetwork.create(self.genome, self.config)
        fitness_max = 0
        count1 = 0
        fitness = 0
        done = False
        while not done:
            #env.render()
            screen = cv2.cvtColor(screen, cv2.COLOR_BGR2GRAY)
            screen = np.reshape(screen, (in_x, in_y))
            screen_inp = [y for x in screen for y in x]
            #action = env.action_space.sample()
            action = net.activate(screen_inp)
            action = argmax(action)
            print('output of NN: ', action)
            #print('input to NN: ', screen_inp)
            screen, reward, done, info = env.step(action)
            fitness += reward
            if fitness > fitness_max:
                fitness_max = fitness
                count1 = 0
            else:
                count1 += 1
            if count1 == 300:
                done = True
                env.close()
            return fitness

def eval_genomes(genome, config):
    worky = Worker(genome, config)
    return worky.work()

config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction, 
                     neat.DefaultSpeciesSet, neat.DefaultStagnation,
                     'config-SpaceInvaders')

p = neat.Population(config)
p.add_reporter(neat.StdOutReporter(True))
stats = neat.StatisticsReporter()
p.add_reporter(stats)
p.add_reporter(neat.Checkpointer(10))
pe = neat.ParallelEvaluator(10, eval_genomes)
winner = p.run(pe.evaluate, 50)
print('\nBest genome:\n{!s}'.format(winner))
with open('winner.pkl', 'wb') as output:
        pickle.dump(winner, output, 1)