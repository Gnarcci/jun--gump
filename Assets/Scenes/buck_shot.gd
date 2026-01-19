extends GunState
const SCENE = preload("res://Assets/Scenes/buckshot.tscn")
const SPRITE = preload("res://InkScape/buckshot.png")
const TYPE = "Buckshot"
var image = Image.new()
func enter():
	scene = SCENE
	force = 1
	gun.gun_animator.play("buckshot")
