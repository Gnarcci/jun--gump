extends Node2D
@export var gun_controller : Gun
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func play(animation):
	animation_player.play(animation)
	
func change_sprite(sprite):
	sprite.texture = sprite
	
func handle_flip_h():
	if gun_controller.direction == 1:
		sprite.flip_h = false
	elif gun_controller.direction == -1:
		sprite.flip_h = true
	
func handle_flip_v():
	if gun_controller.direction == 1:
		sprite.flip_v = false
	elif gun_controller.direction == -1:
		sprite.flip_v = true
	
