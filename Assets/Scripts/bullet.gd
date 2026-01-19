extends CharacterBody2D

var explosion_force = 1500
var knockback = .75
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@export var MAX_BOUNCES = 4 
@onready var timer: Timer = $Timer
var bounces : int = 0
var collision_ready = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += delta
	self.rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	if not collision: 
		return
	
	bounces +=1
	if bounces >= MAX_BOUNCES:
		queue_free()
	velocity = velocity.bounce(collision.get_normal())
	
func _ready() -> void:
	timer.wait_time = .01
	timer.one_shot = true
	if timer.is_stopped():
		timer.start()
	timer.timeout.connect(_on_timer_timeout)
	self.rotation = velocity.angle()
	
func reflect(player:Node2D) -> void:
	var relection_direction = (player.global_position - global_position).normalized()
	velocity = relection_direction * explosion_force 
	bounces +=1
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)

func _on_timer_timeout():
	collision_ready = true
