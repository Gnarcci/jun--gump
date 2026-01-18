extends GunState
const SCENE = preload("res://Assets/Scenes/buckshot.tscn")
const SPRITE = preload("res://Assets/Sprites/buckshot.png")
const TYPE = "Buckshot"

func enter():
	scene = SCENE
	force = 1
	sprite = SPRITE
