extends Node2D
@export var sprite : Sprite2D

var EXPLOSION_FORCE : float = Global.EXPLOSION_FORCE
var state_array = []
var weapon_index = 0
var current_state
var previous_state
var next_state
@onready var states = $StateMachine

func _ready() -> void:
	for state in states.get_children():
		state.states = states
		state.gun = self
		state_array.append(state)
	current_state = states.bullet
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_weapon"):
		weapon_index += 1
	if Input.is_action_just_pressed("previous_weapon"):
		weapon_index -= 1
	check_weapon()
	if Input.is_action_just_pressed("fire"):
		fire(current_state.scene)
		
func check_weapon():
	if weapon_index < 0:
		weapon_index = state_array.size() - 1
	if weapon_index > state_array.size() - 1:
		weapon_index = 0
	next_state = state_array[weapon_index]
	change_state(next_state)
	

func change_state(next_state):
	if next_state != null:
		previous_state = current_state
		current_state = next_state
		previous_state.exit()
		current_state.enter()
		print("from " + previous_state.TYPE + " to " + current_state.TYPE)
		
func fire(projectile : PackedScene):
	var bullet_instance = projectile.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.velocity = current_state.force * get_forward_direction()


func get_forward_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())


		
