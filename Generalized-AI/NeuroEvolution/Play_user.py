# -*- coding: utf-8 -*-
"""
Created on Wed Apr  3 00:37:52 2019

@author: Abhista
"""

import gym
import tkinter as tk

def playgame(event = None):
    env.render()
    if event is not None:
        press = event.char
        print(press)
        if (press == 'a' or press == 's' or press == 'd' 
            or press == 'A' or press == 'S' or press == 'D'):
            if press == 's':
                action = 1
            elif press == 'd':
                action = 2
            elif press == 'a':
                action = 3
            elif press == 'D':
                action = 4
            elif press == 'A':
                action = 5
    else:
        action = 0
    _, _, done, _ = env.step(action)
    if done:
        env.close()
        root.destroy()

env = gym.make('SpaceInvaders-v0')
root = tk.Tk()
root.bind_all('<Key>', playgame)
done = False
env.reset()
root.after(0,playgame)
root.mainloop()