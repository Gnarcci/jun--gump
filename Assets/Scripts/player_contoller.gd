extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var air_control = 3
var jump_multiplier = -30.0
var direction = 0
var knockback : Vector2 = Vector2.ZERO
var bullet_time : bool

signal hit

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	#if knockback_mode:
	#velocity += knockback + (get_gravity() * delta)
		
	#if is_on_floor():
		#knockback_mode = false
	#else:
	movement(delta)
		
	move_and_slide()
	
func movement(delta: float):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		if is_on_floor():
			velocity.x = direction * speed * speed_multiplier
		else:
			print(direction)
			if velocity.x < direction*speed*speed_multiplier or velocity.x > direction*speed*speed_multiplier:
				velocity.x += direction * speed * air_control
			#velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	print("knockback")
	
	



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		if body.bounces > 0:
			print("OK!")
			knockback = body.velocity
			hit.emit()
			body.reflect(self)
			velocity += knockback
			
			


func _on_area_1_bullet_time() -> void:
	if bullet_time != true:
		bullet_time = true
	else:
		bullet_time = false
