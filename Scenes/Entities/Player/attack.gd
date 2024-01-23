extends "state.gd"
@onready var animation = $"../../AnimationPlayer"
@onready var timer = $Timer
@export var time = 0.1
# Called when the node enters the scene tree for the first time.
func update(delta):
	Player.gravity_fall(delta)
	player_movement(delta)
	if Player.movement_input.x == 0 and !animation.is_playing() and Player.is_on_floor():
		return STATES.IDLE
	if Player.movement_input.x != 0 and !animation.is_playing() and Player.is_on_floor():
		return STATES.MOVE 
	if Player.velocity.y > 0 and !animation.is_playing():
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.jump_input_actuation and !animation.is_playing() and Player.can_jump:
		return STATES.JUMP
func enter_state():
	animation.play("Attack_Run")
	pass
func exit_state():
	pass


