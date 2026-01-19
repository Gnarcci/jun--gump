extends PlayerState


func enter():
	string = "fall"
	
func exit():
	pass
	
func draw():
	pass
	
func update(delta: float):
	player.handle_gravity(delta)
	player.handle_movement()
	player.handle_landing()
	handle_animations()
	
func handle_animations():
	player.animation_player.play("fall")
	
