extends "state.gd"

@onready var animation = $"../../AnimationPlayer"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() and Player.jump_input_actuation:
		return STATES.SLIDE
	if Player.jump_input_actuation and Player.jump_count < Player.jump_max:
		return STATES.JUMP
	if Player.jump_input_released and Player.velocity.y < Player.JUMP_VELOCITY / 2.5:
		Player.velocity.y = Player.JUMP_VELOCITY / 2.5
	if Player.attack_input:
		return STATES.ATTACK
	
func enter_state():
	Player.jump_count += 1
	Player.velocity.y = Player.JUMP_VELOCITY
	animation.play("Jump")


func _on_timer_timeout():
	pass
	
