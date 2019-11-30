import gym
import neat
import pickle
import cv2
import numpy as np

def run(config_file):
    config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction,
                         neat.DefaultSpeciesSet, neat.DefaultStagnation,
                         config_file)
    pop = neat.Population(config)
    pop.add_reporter(neat.StdOutReporter(True))
    stats = neat.StatisticsReporter()
    pop.add_reporter(stats) 
    winner = pop.run(eval_genomes)
    with open('MountainCar_AI.pkl', 'wb') as output:
        pickle.dump(winner, output, 1)
    print('\nBest genome:\n{!s}'.format(winner))
    
def eval_genomes(genomes, config):
    global max_fitness
    count = 1
    for genome_id, genome in genomes:
        observation = env.reset()
        net = neat.nn.FeedForwardNetwork.create(genome, config)
        genome.fitness = 0
        done = False
        print('in loop for ', count)
        while not done:
            #env.render()
            action = net.activate(observation)
            observation, reward, done, info = env.step(action)
            genome.fitness += reward
        if genome.fitness > max_fitness:
            max_fitness = genome.fitness
            print('The current max fitness is: ',max_fitness)
        count += 1 


if __name__ == '__main__':
    env = gym.make('MountainCarContinuous-v0')
    config_file = 'config-MountainCar'
    max_fitness = 0
    run(config_file)