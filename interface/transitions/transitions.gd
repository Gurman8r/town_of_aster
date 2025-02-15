# transitions.gd
class_name Transitions extends Control

signal finished()

@onready var dissolve_rect = $DissolveRect
@onready var animation_player = $AnimationPlayer

func _init() -> void:
	Util.set_recursive(self, "mouse_filter", Control.MOUSE_FILTER_IGNORE)

func _ready() -> void:
	reset()

func play(animation: String) -> void:
	match animation:
		"RESET": 	reset()
		"fadeout": 	fadeout()
		"fadein": 	fadein()
		_:
			animation_player.play(animation)
			await animation_player.animation_finished

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func reset() -> void:
	animation_player.play("RESET")

func fadein() -> void:
	animation_player.play("dissolve")
	await animation_player.animation_finished
	finished.emit()

func fadeout() -> void:
	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished
	finished.emit()

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
