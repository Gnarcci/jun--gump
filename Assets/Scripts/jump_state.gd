extends PlayerState

func enter():
	string = "jump"
	player.velocity.y = player.jump_power * player.jump_multiplier
	
func exit():
	pass
	
func draw():
	pass
	
func update(delta: float):
	player.handle_gravity(delta)
	player.handle_movement()
	handle_fall()
	handle_animations()
	
func handle_fall():
	if player.velocity.y >= 0:
		player.change_state(states.fall)

func handle_animations():
	player.animation_player.play("jump")
	player.animation_player.handle_flip_h()
