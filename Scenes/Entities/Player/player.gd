extends CharacterBody2D




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

#player input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var current_state = null
var prev_state = null

@onready var STATES = $STATES

func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
		
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	move_and_slide()
	
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()
		
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
		
	#climb
	if Input.is_action_pressed("climb"):
		climb_input = true
	else:
		climb_input = false 
		
	#dash
	if Input.is_action_pressed("dash"):
		dash_input = true
	else:
		dash_input = false 
	
