# -*- coding: utf-8 -*-
"""
Created on Fri Mar 29 14:47:42 2019
33600
@author: Abhista
"""

import gym
import numpy as np
import cv2
import neat
import pickle
from time import process_time


def run(config_file):
    config = neat.config(neat.DefaultGenome, neat.DefaultReproduction,
                         neat.DefaultSpeciesSet, neat.DefaultStagnation,
                         config_file)
    pop = neat.Population(config)
    pop.add_reporter(neat.StdOutReporter(True))
    stats = neat.StatisticsReporter()
    pop.add_reporter(stats)
    #pop.add_reporter(neat.Checkpointer(5))
    winner = pop.run(eval_genomes,50)
    with open('Breakout_AI.pkl', 'wb') as output:
        pickle.dump(winner, output, 1)
    print('\nBest genome:\n{!s}'.format(winner))
    
    
def eval_genomes(genomes, config):
    count2 = 1
    fitness_max = 0
    for genome_id, genome in genomes:
        screen = env.reset()
        #in_x, in_y, in_c = env.observation_space.shape #Needed when reshaping image resolution
        net = neat.nn.FeedForwardNetwork.create(genome, config)
        fitness = 0
        fitness_between = 0
        fitness_total = 0
        temp = 0
        lives = 5
        done = False
        print('in for loop for ', count2, end = " ")
        start_time = process_time()
        while not done:
            #env.render()
            screen = cv2.cvtColor(screen, cv2.COLOR_BGR2GRAY)
            screen = cv2.resize(screen[60:200,10:150], (30,30)) #Needed only when trying to reduce image resolution
            #cv2.imshow('main', screen)
            screen_inp = [y for x in screen for y in x]
            #action = env.action_space.sample()
            action = net.activate(screen_inp)
            action = np.argmax(action)
            #print('output of NN: ', action)
            screen, reward, done, info = env.step(action)    
            fitness += reward
            fitness_total += reward
            fitness_between += reward
            if info['ale.lives'] < lives:
                temp = fitness_between/1000 * fitness_total
                fitness = fitness - temp
                fitness_between = 0
            lives = info['ale.lives']
            if fitness_total > fitness_max:
                fitness_max = fitness_total
                print(fitness_max, ' is the current max_fitness')
            genome.fitness = fitness
        count2 += 1
        stop_time = process_time()
        print('time = {0}'.format(stop_time - start_time))
        if fitness_max > best_overall_fitness:
            with open('Breakout_AI_Internal.pkl', 'wb') as output:
                pickle.dump(genome, output, 1)


if __name__ == '__main__':
    best_overall_fitness = 0
    env = gym.make('Breakout-v0')
    config_file = 'config-Breakout'
    run(config_file)