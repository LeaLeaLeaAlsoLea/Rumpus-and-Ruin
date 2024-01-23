extends "state.gd"


@onready var animation = $"../../AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func update(delta):
	Player.gravity_fall(delta)
	slide_movement(delta)
	if Player.get_next_to_wall() == null:
		return STATES.FALL
	if Player.jump_input_actuation and Player.can_jump:
		return STATES.JUMP
	if Player.is_on_floor() and Player.movement_input.x != 0:
		return STATES.IDLE
	return null
	
func slide_movement(delta):
	player_movement(delta)
#	Player.gravity(delta)
	Player.velocity.y = move_toward(Player.velocity.y,0.0,Player.FRICTION * delta)
	
func enter_state():
	Player.can_jump = true
	animation.play("WallClimb")
	pass
