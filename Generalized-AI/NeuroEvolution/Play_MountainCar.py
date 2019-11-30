import gym
import pickle
import neat

env = gym.make('MountainCarContinuous-v0')
with open('MountainCar_AI.pkl', 'rb') as file:
    genome = pickle.load(file)    
config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction,
                     neat.DefaultSpeciesSet, neat.DefaultStagnation,
                     'config-MountainCar')
net = neat.nn.FeedForwardNetwork.create(genome, config)
done = False
observation = env.reset()
while not done:
    env.render('human')
    action = net.activate(observation)
    print(action)
    observation, reward, done, info = env.step(action)
env.close()