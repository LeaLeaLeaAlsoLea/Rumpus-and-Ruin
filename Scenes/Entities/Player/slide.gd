extends "state.gd"

@export var climb_speed = 50
@export var slide_friction = 0.7

# Called when the node enters the scene tree for the first time.
func update(delta):
	slide_movement(delta)
	if Player.get_next_to_wall()== null:
		return STATES.FALL
	if Player.jump_input_actuation and Player.jump_count < Player.jump_max:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.is_on_floor():
		return STATES.IDLE
	return null
	
func slide_movement(delta):
	player_movement()
	Player.gravity(delta)
	Player.velocity.y *= slide_friction
	
func enter_state():
	Player.jump_count = 0
	pass
