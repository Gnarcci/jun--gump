extends Node2D
@export var sprite : Sprite2D
@export var EXPLOSION_FORCE : float = 700.0

const BULLET = preload("res://Assets/Scenes/bullet.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.velocity = EXPLOSION_FORCE * get_forward_direction()
		

	
func get_forward_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())


		
