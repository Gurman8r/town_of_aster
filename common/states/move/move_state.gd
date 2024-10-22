# move_state.gd
class_name MoveState extends State

@export var body_path: NodePath
@export var animation_tree_path: NodePath

@export var move_speed: float = 75
@export var acceleration: float = 1000
@export var friction: float = 1000

func _enter_state() -> void:
	super._enter_state()

func _exit_state() -> void:
	super._exit_state()
