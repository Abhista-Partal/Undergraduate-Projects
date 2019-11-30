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


def run(config_file):
    config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction,
                         neat.DefaultSpeciesSet, neat.DefaultStagnation,
                         config_file)
    pop = neat.Population(config)
    pop.add_reporter(neat.StdOutReporter(True))
    stats = neat.StatisticsReporter()
    pop.add_reporter(stats)
    #pop.add_reporter(neat.Checkpointer(5))
    winner = pop.run(eval_genomes,50)
    with open('SpaceInvaders_AI.pkl', 'wb') as output:
        pickle.dump(winner, output, 1)
    print('\nBest genome:\n{!s}'.format(winner))
    
    
def eval_genomes(genomes, config):
    count = 1
    fitness_max = 0
    for genome_id, genome in genomes:
        screen = env.reset()
        #in_x, in_y, in_c = env.observation_space.shape #Needed when reshaping image resolution
        net = neat.nn.FeedForwardNetwork.create(genome, config)
        fitness = 0
        fitness_between = 0
        fitness_total = 0
        temp = 0
        lives = 3
        done = False
        print('in for loop for ', count)
        while not done:
            #env.render()
            screen = cv2.cvtColor(screen, cv2.COLOR_BGR2GRAY)
            screen = cv2.resize(screen[15:200,30:125], (int(185/2.5), int(95/2.5))) #Needed only when trying to reduce image resolution
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
        count += 1


if __name__ == '__main__':
    env = gym.make('SpaceInvaders-v0')
    config_file = 'config-SpaceInvaders'
    run(config_file)    