import tkinter as tk
import os

def Call_Train_CartPole():
    os.system('python Neat-CartPole.py')

def Call_AI_CartPole():
    os.system('python Play_CartPole.py')

def Call_Train_MountainCar():
    os.system('python Neat-MountainCar.py')

def Call_AI_MountainCar():
    os.system('python Play_MountainCar.py')

def Call_AI_SpaceInvaders():
    os.system('python RunGame.py')

def Call_Play_user():
    os.system('python Play_user_thread.py')

def Quit():
    quit()

#def Call_Car_simulator_AI():
#    os.system('conda activate car-behavioral-cloning')
#    os.system('d:')
#    os.system('cd D:\\Semester 8th\\Final Year Project\\Udacity Simulator\\How_to_simulate_a_self_driving_car')
#    os.system('python drive.py model.h5')

root = tk.Tk()
root.title("GUI for Generalized AI")
root.geometry("800x800")
root.configure(bg = 'light yellow')

top = tk.Frame(root)
top.pack(side = tk.TOP, expand = 1)
middle1 = tk.Frame(root)
middle1.pack(side = tk.TOP, expand = 1)
middle2 = tk.Frame(root)
middle2.pack(side = tk.TOP, expand = 1)
middle3 = tk.Frame(root)
middle3.pack(side = tk.TOP, expand = 1)
bottom = tk.Frame(root)
bottom.pack(side = tk.BOTTOM, expand = 1)

Train = tk.Button(root, text = "Train AI for CartPole", command = Call_Train_CartPole, height = 5, width = 50)
Train.pack(in_ = top, side = tk.LEFT, expand = 1)
Play_AI = tk.Button(root, text = "AI for CartPole", command = Call_AI_CartPole, height = 5, width = 50)
Play_AI.pack(in_ = top, side = tk.RIGHT, expand = 1)
Train = tk.Button(root, text = "Train AI for MountainCar", command = Call_Train_MountainCar, height = 5, width = 50)
Train.pack(in_ = middle1, side = tk.LEFT, expand = 1)
Play_AI = tk.Button(root, text = "AI for MountainCar", command = Call_AI_MountainCar, height = 5, width = 50)
Play_AI.pack(in_ = middle1, side = tk.RIGHT, expand = 1)
Play_AI = tk.Button(root, text = "AI for SpaceInvaders", command = Call_AI_SpaceInvaders, height = 5, width = 50)
Play_AI.pack(in_ = middle2, side = tk.RIGHT, expand = 1)
Play_user = tk.Button(root, text = "Play SpaceInvaders", command = Call_Play_user, height = 5, width = 50)
Play_user.pack(in_ = middle2, side = tk.LEFT, expand = 1)
Exit = tk.Button(root, text = "Exit", command = Quit, height = 5, width = 50)
Exit.pack(in_ = bottom, expand = 1)
#Car_simulator = tk.Button(root, text = "Car simulator AI", command = Call_Car_simulator_AI, height = 5, width = 50)
#Car_simulator.pack(expand = 1)

root.mainloop()