extends "state.gd"
@onready var animation = $"../../AnimationPlayer"

func update(delta):
	player_movement(delta)
	Player.gravity(delta)
	
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.jump_input_actuation and Player.can_jump:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.movement_input.x == 0:
		return STATES.IDLE
	if Player.attack_input:
		return STATES.ATTACK
		
func enter_state():
	animation.play("Run")
	
func exit_state():
	pass
