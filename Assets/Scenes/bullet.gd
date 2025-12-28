extends CharacterBody2D

 	
@onready var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@export var MAX_BOUNCES = 10 

var bounces : int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity = velocity * clampf(1.0 - drag * delta, 0, 1)
	
	var collision = move_and_collide(velocity * delta)
	if not collision: 
		return
	
	bounces +=1
	if bounces >= MAX_BOUNCES:
		queue_free()
	velocity = velocity.bounce(collision.get_normal())

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if bounces > 0:
		if area.is_in_group("Character"):
			var knockback_direction = (area.global_position - global_position).normalized()
			area.get_parent().apply_knockback(knockback_direction, 400, 0.30)
			queue_free()
