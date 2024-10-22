# main_title_state.gd
class_name MainTitleState extends State

func _enter_state() -> void:
	super._enter_state()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	UI.title_screen.show()

func _exit_state() -> void:
	super._exit_state()
	UI.title_screen.hide()
