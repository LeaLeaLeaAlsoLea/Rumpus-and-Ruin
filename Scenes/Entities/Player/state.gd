extends Node

var STATES = null
var Player = null

func enter_state():
	pass

func exit_state():
	pass

func update(delta):
	return null
	
func player_movement(delta):

	if is_zero_approx(Player.movement_input.x):
		Player.velocity.x = move_toward(Player.velocity.x, 0.0, Player.FRICTION * delta)
	else:
		Player.velocity.x = Player.movement_input.x * Player.SPEED
		Player.last_direction = Player.movement_input

