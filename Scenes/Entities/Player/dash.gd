extends "state.gd"

var dash_direction = Vector2.ZERO
var dash_speed = 700
var dashing = false

@export var dash_duration = 0.4
@export var dash_cooldown = 1
@onready var DashDuration_timer = $DashDuration
@onready var DashCooldown_timer = $DashCooldown

func update(delta):
	if ! dashing:
		return STATES.FALL
	return null
	
func enter_state():
	Player.dash_count += 1
	Player.can_dash = false
	dashing = true
	DashDuration_timer.start(dash_duration)
	dash_direction = Player.last_direction
	Player.velocity = dash_direction.normalized() * dash_speed
	
	
func exit_state():
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
