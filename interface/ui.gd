# ui.gd
# UI
extends Node

var canvas        : CanvasLayer
var splash_screen : SplashScreen
var title_screen  : TitleScreen
var hud           : HUD
var transitions   : Transitions

func _ready() -> void:
	canvas = null
