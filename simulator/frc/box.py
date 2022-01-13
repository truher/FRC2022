from .ball import Ball

import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from random import random, uniform, choice

mpl.use('TkAgg')
BASE_SPEED = 10

class Box:
    def __init__(self, x, y):
        self.size_factor = min(x, y) / 1000
        self.size_x, self.size_y = x, y
        self.balls = []
        self.fig, self.ax = plt.subplots()
        dpi = 100
        self.fig.set_size_inches(self.size_x / dpi, self.size_y / dpi)
        self.fig.set_dpi(dpi)
        self.ax.set_xlim(0, self.size_x), self.ax.set_xticks([])
        self.ax.set_ylim(0, self.size_y), self.ax.set_yticks([])
        self.artist_to_ball = {}
        plt.subplots_adjust(left=0, bottom=0, right=1, top=1, wspace=0, hspace=0)

    def add_random_balls(self, num, random_sizes=True, random_colours=True, speed_factor=1.0, e=1.0):
        i, j = 0, 0
        while i < num:
            if j > num * 5:
                break
            size = choice([25, 30, 35]) if random_sizes else 20
            size = size * self.size_factor
            color = [random() for _ in range(3)] if random_colours else 'b'
            speed = BASE_SPEED * speed_factor * self.size_factor
            ball = Ball(
                x := uniform(size, self.size_x-size), y := uniform(size, self.size_y-size),
                size, uniform(-speed, speed), uniform(-speed, speed), e
            )
            if not any([ball.is_colliding(existing_ball) for existing_ball in self.balls]):
                i += 1
                self.balls.append(ball)
                self.artist_to_ball[self.ax.add_artist(plt.Circle((x, y), size, color=color))] = ball
            j += 1

    def time_step(self, num_steps):
        for ball_idx, ball in enumerate(self.balls):
            ball.time_step(num_steps)
            ball.check_wall_collision(self.size_x, self.size_y)
            for other_ball in self.balls[ball_idx+1:]:
                ball.check_ball_collision(other_ball)

    def update_fig(self, _, num_steps):
        for _ in range(num_steps):
            self.time_step(num_steps)
        for artist in self.ax.get_children():
            ball = self.artist_to_ball.get(artist, None)
            if ball:
                artist.set_center(ball.position)

    def start_animation(self, fps):
        anim = animation.FuncAnimation(
            self.fig, self.update_fig, interval=1000/fps, fargs=(5,)
        )
        plt.show()
