extends CharacterBody2D

var explosion_force = 60
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@onready var animation_player = $AnimationPlayer
@export var MAX_BOUNCES = 3
var knockback = 2.5
var bounces : int = 0
@onready var timer: Timer = $Timer
var collision_ready = false

func _ready() -> void:
	animation_player.play("shot")
	timer.wait_time = .1
	timer.one_shot = true
	if timer.is_stopped():
		timer.start()
	timer.timeout.connect(_on_timer_timeout)
	self.rotation = velocity.angle()
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
	
func reflect(player:Node2D) -> void:
	if player.is_in_group("Character"):
		var relection_direction = (player.global_position - global_position).normalized()
		velocity = relection_direction * explosion_force 
		bounces +=1
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	
func _on_timer_timeout():
	collision_ready = true
