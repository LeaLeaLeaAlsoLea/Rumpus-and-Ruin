extends "state.gd"

@onready var animation = $"../../Animation"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.jump_input_actuation and Player.jump_count < Player.jump_max:
		return STATES.JUMP
	if Player.jump_input_released and Player.velocity.y < Player.JUMP_VELOCITY / 2.5:
		Player.velocity.y = Player.JUMP_VELOCITY / 2.5
	
	return null

func enter_state():
	Player.jump_count += 1
	if Player.jump_input_actuation:
		Player.velocity.y = Player.JUMP_VELOCITY
	animation.play("Jump")


func _on_timer_timeout():
	pass
	
