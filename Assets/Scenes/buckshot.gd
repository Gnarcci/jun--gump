extends CharacterBody2D

var explosion_force = 1
var knockback = -500
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@export var MAX_BOUNCES = 1
@onready var timer: Timer = $Timer
@onready var collision_timer: Timer = $CollisionTimer
@onready var collision: CollisionShape2D = $CollisionShape2D
var collision_ready = true
var bounces : int = 0

signal buckshot_fired
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += delta
	
	self.rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	if not collision: 
		return
	
	
	velocity = velocity.bounce(collision.get_normal())
	
func reflect(player:Node2D) -> void:
	pass
	
func _ready() -> void:
	timer.wait_time = .5
	timer.one_shot = true
	if timer.is_stopped():
		timer.start()
	timer.timeout.connect(_on_timer_timeout)
	collision_timer.wait_time = .1
	collision_timer.one_shot = true
	if collision_timer.is_stopped():
		collision_timer.start()
	collision_timer.timeout.connect(_on_collision_timer_timeout)
	
	
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_timer_timeout():
	queue_free()
	
func _on_collision_timer_timeout():
	collision.disabled = true
