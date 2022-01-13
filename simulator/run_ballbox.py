import argparse
from frc.box import Box

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-s', '--size', nargs=2, default=[1000, 1000], type=int,
        help='The size of the box in pixels. Default: 1000x1000 px.'
    )
    parser.add_argument(
        '-n', '--num', default=30, type=int,
        help='The number of balls to simulate. Default: 60.'
    )
    parser.add_argument(
        '-e', '--elasticity', default=1.0, type=float,
        help='Coefficient of restitution.  Default: 1.0, i.e. perfectly elastic'
    )
    parser.add_argument(
        '--random_sizes', action='store_true',
        help='If present, balls will have random sizes.'
    )
    parser.add_argument(
        '--random_colours', '--random_colors', action='store_true', dest='random_colours',
        help='If present, balls will have random colours.'
    )
    parser.add_argument(
        '--speed', default=1.0, type=float,
        help='The factor affecting the speed of balls in the simulation. Default: 1.'
    )
    parser.add_argument(
        '--fps', default=60, type=int,
        help='The frames per second of the animation. The maximum is 1000fps. Default: 60 fps.'
    )
    args = parser.parse_args()

    box = Box(args.size[0], args.size[1])
    box.add_random_balls(
        args.num, random_sizes=args.random_sizes, random_colours=args.random_colours, speed_factor=args.speed, e=args.elasticity
    )
    box.start_animation(fps=args.fps)
