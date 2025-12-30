extends Node2D
@onready var player = $Player
signal bullet_time
# Called when the node enters the scene tree for the first time.
@export var EXPLOSION_FORCE : = 1000
@onready var DEFAULT_GRAVITY : float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	player.hit.connect(bullet_time_off)
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bullet_time"):
		bullet_time_toggle()
			
			
func bullet_time_toggle() -> void:
	if Engine.time_scale <= 0.1:
		Engine.time_scale = 1
		ProjectSettings.set_setting("physics/2d/default_gravity", DEFAULT_GRAVITY)
		emit_signal("bullet_time")
	else:
		Engine.time_scale = 0.1
		emit_signal("bullet_time")

func bullet_time_off() -> void:
	if Engine.time_scale != 1:
		Engine.time_scale = 1
		ProjectSettings.set_setting("physics/2d/default_gravity", DEFAULT_GRAVITY)



# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_player_hit() -> void:
	bullet_time_off()
	emit_signal("bullet_time")
