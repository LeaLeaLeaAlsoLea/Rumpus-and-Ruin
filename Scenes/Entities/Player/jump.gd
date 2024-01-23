extends "state.gd"

@onready var animation = $"../../AnimationPlayer"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.get_next_to_wall() and Player.jump_input_actuation:
		return STATES.SLIDE
	if Player.jump_input_actuation and Player.can_jump:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() and Player.jump_input_actuation:
		return STATES.SLIDE
	if Player.jump_input_released and Player.velocity.y < Player.JUMP_VELOCITY / 2:
		Player.velocity.y = Player.JUMP_VELOCITY / 2
	if Player.attack_input:
		return STATES.ATTACK
	
func enter_state():
	if Player.prev_state == STATES.JUMP:
		Player.can_jump = false
	Player.velocity.y = Player.JUMP_VELOCITY
	animation.play("Jump")


func _on_timer_timeout():
	pass
	
