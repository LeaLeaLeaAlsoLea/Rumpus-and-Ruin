extends "state.gd"

@onready var CyoteTime = $CyoteTime
@export var cyote_duration = 0.2
@onready var JumpBuffer = $JumpBuffer
@export var jump_buffer_time = 1
@export var jump_is_buffered = false
var can_jump = true

func update(delta):
	Player.gravity_fall(delta)
	player_movement(delta)
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() != null:
		return STATES.SLIDE
		
	if Player.jump_input_actuation and can_jump or Player.jump_input_actuation and Player.jump_count < Player.jump_max:
		return STATES.JUMP
		
	if Player.velocity.y > 800:
		Player.velocity.y = 800
	print(jump_is_buffered)
	return null
	
func enter_state():
	if Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE:
		can_jump = true
		CyoteTime.start(cyote_duration)
	else: 
		can_jump = false

	pass

func exit_state():
	pass
	
func _on_cyote_time_timeout():
	can_jump = false
	pass # Replace with function body.



func _on_jump_buffer_timeout():
	pass
