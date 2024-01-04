extends "state.gd"


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.jump_input_actuation and Player.jump_count < Player.jump_max:
		return STATES.JUMP
	return null
func enter_state():
	Player.jump_count += 1
	Player.velocity.y = Player.JUMP_VELOCITY
	
