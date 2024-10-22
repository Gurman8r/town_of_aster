# idle_state.gd
class_name IdleState extends State

@export var body_path: NodePath
@export var animation_tree_path: NodePath

func _enter_state() -> void:
	super._enter_state()

func _exit_state() -> void:
	super._exit_state()
