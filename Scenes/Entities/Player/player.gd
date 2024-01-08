extends CharacterBody2D




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#player input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var jump_input_released = false
var climb_input = false
var dash_input = false

#player_movement
const SPEED = 450.0
const JUMP_VELOCITY = -600.0
const ACCELERATION = 1300.0
const FRICTION = 3000.0
var last_direction = Vector2.RIGHT

#mechanics
var can_dash = true
var dash_count = 0
var dash_max = 2
var jump_count = 0
var jump_max = 2

#states
var current_state = null
var prev_state = null

#nodes
@onready var Raycasts = $Raycasts
@onready var STATES = $STATES
@onready var animation = $Animation

#interactibles
var coins = 0

func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
	
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	flip_sprite()
	$Label.text = str(current_state.get_name())
	move_and_slide()
	
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
func gravity_fall(delta):
	if not is_on_floor():
		velocity.y += gravity_value * 1.4 * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()
		
func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null
	
func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movement_input.x += 1
	if Input.is_action_pressed("left"):
		movement_input.x -= 1
	if Input.is_action_pressed("up"):
		movement_input.y -= 1
	if Input.is_action_pressed("down"):
		movement_input.y += 1
	
	# jumps	
	if Input.is_action_pressed("jump"):
		jump_input = true
	else:
		jump_input = false
	if Input.is_action_just_pressed("jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
	if Input.is_action_just_released("jump"):
		jump_input_released = true
	else:
		jump_input_released = false
		
	#climb
	if Input.is_action_pressed("climb"):
		climb_input = true
	else:
		climb_input = false 
		
	#dash
	if Input.is_action_just_pressed("dash"):
		dash_input = true
	else:
		dash_input = false 
	
func flip_sprite():
	if movement_input.x > 0:
		animation.flip_h = false
	elif movement_input.x <0:
		animation.flip_h = true

func add_coin():
	coins += 1
