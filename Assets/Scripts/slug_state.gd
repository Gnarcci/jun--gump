extends GunState
const SLUG = preload("res://Assets/Scenes/slug.tscn")
const TYPE = "Slug"

func enter():
	scene = SLUG
	force = 300
