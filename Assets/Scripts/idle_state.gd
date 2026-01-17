extends PlayerState


func enter():
	string = "idle"
	
func exit():
	pass
	
func draw():
	pass
	
func update(delta:float):
	player.handle_gravity(delta)
	player.handle_falling()
	player.handle_jump()
	player.handle_movement()
	if player.direction != 0:
		player.change_state(states.run)
	handle_animations()

func handle_animations():
	player.animation_player.play("idle")
	player.animation_player.handle_flip_h()
