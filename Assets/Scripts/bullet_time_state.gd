extends PlayerState

@onready var timer: Timer = $Timer
var bullet_time_speed_multiplier = 8

	
func enter():
	timer.wait_time = .5
	timer.one_shot = true
	string = "bullet time"
	if timer.is_stopped():
		timer.start()
	Engine.time_scale = 0.1
	timer.timeout.connect(_on_timer_timeout)
	print("enter")
	
func exit():
	Engine.time_scale = 1 
	
func draw():
	pass
	
func update(delta: float):
	print(timer.time_left)
	handle_bullet_time_movement()
	handle_idle()
	
func handle_bullet_time_movement():
	var direction_x = Input.get_axis("move_left", "move_right")
	
	if direction_x:
		player.velocity.x = direction_x * player.speed * player.speed_multiplier
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, bullet_time_speed_multiplier)
		
	var direction_y = Input.get_axis("move_up", "move_down")
	
	if direction_y:
		player.velocity.y = direction_y * player.speed * player.speed_multiplier	
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, bullet_time_speed_multiplier)
		
func handle_idle():
	if player.is_on_floor():
		player.change_state(states.idle)
		
func _on_timer_timeout() -> void:
	player.change_state(states.idle)
