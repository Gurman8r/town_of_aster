# title_screen.gd
class_name TitleScreen extends Control

enum { NONE, HOME }

signal menu_changed(value: int)

var _menu: int = HOME

func _init() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS

func set_menu(value: int) -> void:
	if _menu == value: return
	_menu = value
	menu_changed.emit(_menu)
