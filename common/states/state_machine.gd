# state_machine.gd
class_name StateMachine extends Node

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

@export var _state: State
var state: State : get = get_state, set = change_state
func get_state() -> State: return _state

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func _ready() -> void:
	if _state == null \
	and 0 < get_child_count() \
	and get_child(0) is State:
		_state = get_child(0) as State
	if _state is State:
		_state._enter_state()

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func change_state(value: State) -> void:
	if _state == value: return
	if _state: _state._exit_state()
	_state = value
	if _state: _state._enter_state()

func force_exit() -> void:
	if _state: _state._exit_state()
	_state = null

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
