extends CharacterBody2D

var explosion_force = 300
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@export var MAX_BOUNCES = 3

var bounces : int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += delta
	velocity = velocity * clampf(1.0 - drag * delta, 0, 1)
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
