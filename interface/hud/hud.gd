# hud.gd
class_name HUD extends Control

@onready var hotbar: InventoryHotbar = $hotbar
@onready var interact_label: Label = $interact_label
@onready var healthbar = $Bars/healthbar
@onready var staminabar = $Bars/staminabar
@onready var manabar = $Bars/manabar
@onready var expbar = $Bars/expbar
