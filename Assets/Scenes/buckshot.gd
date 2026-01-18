extends CharacterBody2D

var explosion_force = 1
var knockback = -500
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@export var MAX_BOUNCES = 1
@onready var timer: Timer = $Timer
var collision_ready = true
var bounces : int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += delta
	velocity = velocity * clampf(1.0 - drag * delta, 0, 1)
	self.rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	if not collision: 
		return
	
	
	velocity = velocity.bounce(collision.get_normal())
	
func reflect(player:Node2D) -> void:
	pass
	
func _ready() -> void:
	timer.wait_time = .2
	timer.one_shot = true
	if timer.is_stopped():
		timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
func _on_timer_timeout():
	queue_free()
