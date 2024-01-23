extends "state.gd"

@onready var CyoteTime = $CyoteTime
@export var cyote_duration = 0.2
@onready var JumpBuffer = $JumpBuffer
@export var jump_buffer_time = 0.1
@export var jump_is_buffered = false
@onready var animation = $"../../AnimationPlayer"
var can_jump = true

func update(delta):
	Player.gravity_fall(delta)
	player_movement(delta)
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() != null and Player.jump_input:
		return STATES.SLIDE
	elif (Player.jump_input_actuation and can_jump) or (Player.jump_input_actuation and Player.jump_count < Player.jump_max):
		return STATES.JUMP
	elif Player.jump_input_actuation and Player.jump_count == Player.jump_max:
		JumpBuffer.start(jump_buffer_time)
		jump_is_buffered = true
	elif jump_is_buffered and Player.is_on_floor():
		Player.jump_count = 0
		return STATES.JUMP
	if Player.is_on_floor() and Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.is_on_floor() and Player.movement_input.x == 0:
		return STATES.IDLE
	if Player.attack_input:
		return STATES.ATTACK
	if Player.velocity.y > 800:
		Player.velocity.y = 800
	
func enter_state():
	if Player.prev_state == STATES.MOVE:
		can_jump = true
		CyoteTime.start(cyote_duration)
	else: 
		can_jump = false
	animation.play("Pre_Fall")
#	animation. ("Fall")
func exit_state():
	pass
	
func _on_cyote_time_timeout():
	can_jump = false

func _on_jump_buffer_timeout():
	jump_is_buffered = false
