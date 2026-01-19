extends Node2D
class_name Gun
@export var sprite : Sprite2D
@onready var gun_animator = $GunAnimator


var EXPLOSION_FORCE : float = Global.EXPLOSION_FORCE
var state_array = []
var previous_weapon_index = 0
var weapon_index = 0
var current_state
var previous_state
var next_state
@onready var muzzle: Marker2D = $Marker2D
@onready var states = $StateMachine

func _ready() -> void:
	for state in states.get_children():
		state.states = states
		state.gun = self
		state_array.append(state)
	current_state = states.bullet
	change_state(current_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_weapon"):
		weapon_index += 1
	if Input.is_action_just_pressed("previous_weapon"):
		weapon_index -= 1
	check_weapon()
	if Input.is_action_just_pressed("fire"):
		fire(current_state.scene)
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees,0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		sprite.flip_v = true
	else: 
		sprite.flip_v = false
		
func check_weapon():
	if weapon_index < 0:
		weapon_index = state_array.size() - 1
	if weapon_index > state_array.size() - 1:
		weapon_index = 0
	if weapon_index != previous_weapon_index:
		previous_weapon_index = weapon_index
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
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.velocity = current_state.force * get_forward_direction()


func get_forward_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())


		
