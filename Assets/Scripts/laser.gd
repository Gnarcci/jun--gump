extends Node2D
@export var sprite : Sprite2D
var EXPLOSION_FORCE : float = Global.EXPLOSION_FORCE
@onready var TEST_BULLET: CharacterBody2D = $"test bullet"

const BULLET = preload("res://Assets/Scenes/bullet.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	update_trajectory()
	
func get_forward_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())

func update_trajectory() -> void:
	var velocity : Vector2 = EXPLOSION_FORCE * get_forward_direction()
	var line_start := global_position
	var line_end :Vector2
	var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
	var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
	var timestep := 0.02
	var colors := [Color.RED, Color.RED]
	var max_bounces = 3
	var bounces = 1
	TEST_BULLET.global_position = line_start
	
	for i:int in 30:
		velocity.y += timestep
		velocity = velocity * clampf(1.0 - drag * timestep, 0 , 1)
		line_end = line_start + (velocity * timestep)
		
		var collision := TEST_BULLET.move_and_collide(velocity*timestep)
		
		if collision and bounces <= max_bounces:
			velocity = velocity.bounce(collision.get_normal())
			draw_line_global(line_start, TEST_BULLET.global_position, Color.YELLOW)
			line_start = TEST_BULLET.global_position
			bounces +=1
			continue
			
		draw_line_global(line_start, line_end, colors[i%2])
		line_start = line_end
			

func draw_line_global(point_a:Vector2,point_b:Vector2,color:Color, width:int = -1 ):
	var local_offset := point_a - global_position
	var point_b_local := point_b - global_position
	draw_line(local_offset, point_b_local, color, width)

		
