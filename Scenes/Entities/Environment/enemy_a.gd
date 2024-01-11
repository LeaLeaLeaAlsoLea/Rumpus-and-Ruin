extends CharacterBody2D

var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")


var speed = 100
var player_chase = false
var player = null

var body


func _physics_process(delta):
	if player_chase == true:
		position.x += (player.position.x - position.x)/ speed
		move_and_slide()
	if not is_on_floor():
		velocity.y += gravity_value * speed * delta 


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false


