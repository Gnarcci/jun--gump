extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("Player")
	player.hit.connect(bullet_time_off)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bullet_time"):
		bullet_time_toggle()
			
			
func bullet_time_toggle() -> void:
	if Engine.time_scale <= 0.1:
		Engine.time_scale = 1
	else:
		Engine.time_scale = 0.1

func bullet_time_off() -> void:
	if Engine.time_scale != 1:
		Engine.time_scale = 1
