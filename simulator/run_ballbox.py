from frc.box import Box

box = Box()
box.add_random_balls(30, e=0.75)
box.start_animation(fps=60)
