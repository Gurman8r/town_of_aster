# player.gd
class_name Player extends StaticBody3D

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

enum { LEFT, RIGHT, FORWARD, BACKWARD }
enum { PRIMARY_BEGIN, PRIMARY, PRIMARY_END, SECONDARY_BEGIN, SECONDARY, SECONDARY_END, }

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

signal action(mode: int)
signal moved(delta: float, direction: Vector3)
signal collided(body: KinematicCollision3D)

signal toggle_inventory()
#signal toggle_map()
#signal toggle_collection()
#signal toggle_skills()
#signal toggle_journal()
#signal toggle_settings()
#signal toggle_system()

signal hotbar_prev()
signal hotbar_next()
signal hotbar_select(index: int)

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

@export var data: PlayerData

@export var move_speed: float = 5
@export var turn_speed: float = 15
@export var drop_range: float = 2
@export var drop_height: float = 0.5
@export var target_range: float = 1
@export var target_height: float = 0
@export var camera_speed: Vector2 = Vector2(0.005, 0.005)
@export var camera_angle_min_degrees: float = -70
@export var camera_angle_max_degrees: float = 15

@onready var animation_player   : AnimationPlayer  = $AnimationPlayer
@onready var animation_tree     : AnimationTree    = $AnimationTree

@onready var camera_pivot_y     : Node3D           = $CameraPivotY
@onready var camera_pivot_x     : SpringArm3D      = $CameraPivotY/CameraPivotX
@onready var camera_3d          : Camera3D         = $CameraPivotY/CameraPivotX/Camera3D

@onready var collider           : CollisionShape3D = $Collider
@onready var interact_ray       : InteractRay      = $InteractRay
@onready var rotor              : Node3D           = $Rotor
@onready var sprite             : Sprite3D         = $Sprite
@onready var target_marker      : Node3D           = $TargetMarker

@onready var state_machine      : StateMachine     = $StateMachine
@onready var move_state         : MoveState        = $StateMachine/MoveState

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

var move_input: Array[bool] = [0, 0, 0, 0]

var right: Vector3:
	get: return camera_pivot_y.transform.basis.x

var left: Vector3:
	get: return -camera_pivot_y.transform.basis.x

var backward: Vector3:
	get: return camera_pivot_y.transform.basis.z

var forward: Vector3:
	get: return -camera_pivot_y.transform.basis.z

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func _init() -> void:
	pass

func _ready() -> void:
	assert(data != null)

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func _process(delta: float) -> void:
	if not data: return
	
	# movement
	var input_vector: Vector3 = Vector3.ZERO
	if move_input[RIGHT]: input_vector += right
	elif move_input[LEFT]: input_vector += left
	if move_input[BACKWARD]: input_vector += backward
	elif move_input[FORWARD]: input_vector += forward
	input_vector.y = 0
	input_vector = input_vector.normalized()
	if input_vector.x != 0 or input_vector.z != 0:
		data.direction = (data.direction + input_vector).normalized()
		var body = move_and_collide(input_vector * move_speed * delta)
		moved.emit(delta, input_vector)
		if body: collided.emit(body)
	data.position = global_transform.origin
		
	# rotation
	if data.direction.x != 0 and data.direction.z != 0:
		var rot: Basis = rotor.basis.slerp(Basis.looking_at(data.direction), turn_speed * delta)
		rotor.basis = rot
		interact_ray.basis = rot
	
	# targeting
	target_marker.global_transform.origin.x = roundf(data.position.x + data.direction.x * target_range)
	target_marker.global_transform.origin.z = roundf(data.position.z + data.direction.z * target_range)
	target_marker.global_transform.origin.y = target_height

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func pivot(relative: Vector2) -> void:
	camera_pivot_y.rotate_y(-relative.x * camera_speed.x)
	camera_pivot_x.rotate_x(-relative.y * camera_speed.y)
	camera_pivot_x.rotation.x = clamp(
		camera_pivot_x.rotation.x,
		deg_to_rad(camera_angle_min_degrees),
		deg_to_rad(camera_angle_max_degrees))

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func get_drop_position() -> Vector3:
	return Vector3(
		global_transform.origin.x + data.direction.x * drop_range,
		drop_height,
		global_transform.origin.z + data.direction.z * drop_range)

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
