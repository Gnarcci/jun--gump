extends PlayerState


func enter():
	string = "run"
	
func exit():
	pass
	
func draw():
	pass
	
func update(delta: float):
	player.handle_gravity(delta)
	player.handle_movement()
	player.handle_jump()
	player.handle_falling()
	handle_animations()
	handle_idle()
	
func handle_idle():
	if player.direction == 0:
		player.change_state(states.idle)
		
func handle_animations():
	player.animation_player.play("move")
	
