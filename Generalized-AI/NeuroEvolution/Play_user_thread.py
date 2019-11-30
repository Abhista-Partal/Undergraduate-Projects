# -*- coding: utf-8 -*-
"""
Created on Sun Apr 14 18:41:46 2019

@author: Abhista
"""

import gym
import tkinter as tk
import threading
from queue import Queue
from time import sleep

def create_task():
    while True:
        task = q.get()
        play(task)
        q.task_done()

def play(task):
    if task == 0:
        env = gym.make('SpaceInvaders-v0')
        global action, done
        env.reset()
        done = False
        action = 0
        sleep(2)
        while not done:
            env.render()
            sleep(0.02)
            with action_lock:
                _, _, done, _ = env.step(action)
        env.close()
    else:
        global root
        root = tk.Tk()
        root.bind_all('<Key>', set_action)
        root.mainloop()

def set_action(event = None):
    press = event.char
    #print(press)
    with action_lock:
        global action, root
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
        elif press == 'L':
            root.destroy()

if __name__ == '__main__':
    q = Queue()
    action_lock = threading.Lock()
    for x in range(2):
        t = threading.Thread(target = create_task)
        t.daemon = True
        t.start()

    for task in range(2):
        q.put(task)

    q.join()