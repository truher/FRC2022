import transitions # type: ignore

states = ['chasing_cargo', 'chasing_bots', 'shooting', 'climbing']

transitions = [
    ['hunt_cargo', 'shooting', 'chasing_cargo'],
    ['defending', ['chasing_cargo', 'shooting'], 'chasing_bots'],
    ['endgame', '*', 'climbing']
]
