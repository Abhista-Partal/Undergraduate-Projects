import gym
import pickle
import neat

env = gym.make('Pendulum-v0')
with open('Pendulum_AI.pkl', 'rb') as file:
    genome = pickle.load(file)    
config = neat.Config(neat.DefaultGenome, neat.DefaultReproduction,
                     neat.DefaultSpeciesSet, neat.DefaultStagnation,
                     'config-Pendulum')
net = neat.nn.FeedForwardNetwork.create(genome, config)
done = False
observation = env.reset()
while not done:
    env.render('human')
    action = net.activate(observation)
    print(action)
    observation, reward, done, info = env.step(action)
env.close()