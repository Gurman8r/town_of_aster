# player_data.gd
class_name PlayerData extends Resource

@export var guid: String = "Player"
@export var name: String = "Player"
@export var cell_name: String = ""
@export var position: Vector3 = Vector3.ZERO
@export var direction: Vector3 = Vector3.FORWARD

@export var gender: int = 0
@export var pronoun0: String = "She"
@export var pronoun1: String = "Her"

enum { CAT, DOG }
@export var pet_species: int = CAT
@export var pet_breed: int = 0

@export var experience: int = 0
@export var health_current: int = 100
@export var health_max: int = 100
@export var stamina_current: int = 100
@export var stamina_max: int = 100
@export var mana_current: int = 100
@export var mana_max: int = 100

@export var inventory: InventoryData = InventoryData.new()
