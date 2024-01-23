extends "state.gd"

var dash_direction = Vector2.ZERO
var dash_speed = 700
var dashing = false
@onready var animation = $"../../AnimationPlayer"
@export var dash_duration = 0.4
@export var dash_cooldown = 1
@onready var DashDuration_timer = $DashDuration
@onready var DashCooldown_timer = $DashCooldown

func update(delta):
	if ! dashing:
		return STATES.FALL
		
	if Player.last_direction.x > 0:
		dash_direction = Vector2.RIGHT
	elif Player.last_direction.x < 0:
		dash_direction = Vector2.LEFT
	else:
		dash_direction = Player.last_direction
	Player.velocity = dash_direction.normalized() * dash_speed
	return null
	
func enter_state():
	Player.dash_count += 1
	Player.can_dash = false
	dashing = true
	animation.play("Dash")
	DashDuration_timer.start(dash_duration)
	
	
func exit_state():
	animation.stop()
	dashing = false


func _on_timer_timeout():
	dashing = false
	if Player.dash_count < Player.dash_max:
		Player.can_dash = true
	else:
		Player.can_dash = false
		DashCooldown_timer.start(dash_cooldown)
	pass # Replace with function body.


func _on_dash_cooldown_timeout():
	Player.dash_count = 0
	Player.can_dash = true
	pass # Replace with function body.
