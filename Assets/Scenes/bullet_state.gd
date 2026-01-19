extends GunState
const BULLET = preload("res://Assets/Scenes/bullet.tscn")
const TYPE = "Bullet"

func enter():
	scene = BULLET
	force = 1000
	gun.gun_animator.play("bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
