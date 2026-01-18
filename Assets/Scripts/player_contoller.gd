extends CharacterBody2D
class_name PlayerController

@onready var animation_player = $PlayerAnimator

@export var speed = 10.0
@export var jump_power = 10.0

var key_up = false
var key_down = false
var key_right = false
var key_left = false
var key_jump = false
var key_jump_pressed = false
var key_bullet_time = false

var friction = 15
var speed_multiplier = 20.0
var air_control = 1
var jump_multiplier = -30.0
var direction = 0
var knockback : Vector2 = Vector2.ZERO
var bullet_time : bool
var current_state
var previous_state
var facing = 0
var default_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var states = $StateMachine
signal hit

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

func _ready():
	for state in states.get_children():
		state.states = states
		state.player = self
		 
	current_state = states.fall
func _physics_process(delta: float) -> void:
	get_input_states()
	
	current_state.update(delta)
	
	handle_movement()
	handle_jump()
	handle_bullet_time()
	
	move_and_slide()
	
func get_input_states():
	key_up = Input.is_action_just_pressed("move_up")
	key_down = Input.is_action_just_pressed("move_down")
	key_left = Input.is_action_just_pressed("move_left")
	key_right = Input.is_action_just_pressed("move_right")
	key_jump = Input.is_action_just_pressed("jump")
	key_jump_pressed = Input.is_action_just_pressed("jump")
	key_bullet_time = Input.is_action_just_pressed("bullet_time")
	
	if key_right: facing = 1
	if key_left: facing = -1

	
func change_state(next_state):
	if next_state != null:
		previous_state = current_state
		current_state = next_state
		previous_state.exit()
		current_state.enter()
		print("from " + previous_state.string + " to " + current_state.string)
		
func draw():
	current_state.draw()
	
func handle_movement():
	if is_on_floor():
		handle_horizontal_movement()
	else:
		handle_air_movement()
	
func handle_horizontal_movement():
	direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
			
func handle_air_movement():
	direction = Input.get_axis("move_left", "move_right")
	
	if (direction == 1 and velocity.x < speed*speed_multiplier) or (direction == -1 and velocity.x > -1*speed*speed_multiplier):
		velocity.x += direction * speed * air_control
			#velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	print("knockback")
	
	
func handle_falling():
	if !is_on_floor() and velocity.y > 0:
		change_state(states.fall)
		
func handle_gravity(delta, gravity = default_gravity):
	if !is_on_floor():
		velocity += get_gravity() * delta
		


func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		change_state(states.jump)
		
func handle_landing():
	if is_on_floor():
		change_state(states.idle)
		
func handle_bullet_time():
	if key_bullet_time:
		change_state(states.bullet_time)
		print("ye[]")

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		if body.collision_ready and !is_on_floor():
			print("OK!")
			knockback = body.velocity * body.knockback
			hit.emit()
			body.reflect(self)
			change_state(states.knockback)
			
			


func _on_area_1_bullet_time() -> void:
	if bullet_time != true:
		change_state(states.bullet_time)
	else:
		bullet_time = false
