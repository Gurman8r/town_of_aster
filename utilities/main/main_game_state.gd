# main_game_state.gd
class_name MainGameState extends State

func _enter_state() -> void:
	super._enter_state()
	UI.hud.show()

func _exit_state() -> void:
	super._exit_state()
	UI.hud.hide()
