# splash_screen.gd
class_name SplashScreen extends Control

@onready var background: ColorRect = $Background
@onready var icon: TextureRect = $Icon

func _init() -> void:
	Util.set_recursive(self, "mouse_filter", Control.MOUSE_FILTER_IGNORE)
