extends "state.gd"
@onready var animation = $"../../Animation"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if !Player.movement_input:
		return STATES.IDLE
	return null
func enter_state():
	Player.jump_count = 0
	animation.play("Run")
	pass
	
func exit_state():
	animation.stop()
