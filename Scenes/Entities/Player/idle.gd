extends "state.gd"
@onready var animation = $"../../AnimationPlayer"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.jump_input_actuation == true and Player.jump_count <= Player.jump_max:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.attack_input:
		return STATES.ATTACK
	

func enter_state():
	Player.jump_count = 0
	animation.play("Idle")
