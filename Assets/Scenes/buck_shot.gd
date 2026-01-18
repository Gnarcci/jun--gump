extends GunState
const SCENE = preload("res://Assets/Scenes/buckshot.tscn")
const TYPE = "Buckshot"

func enter():
	scene = SCENE
	force = 1
