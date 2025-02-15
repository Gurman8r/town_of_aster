# item_data.gd
class_name ItemData extends Resource

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

enum {
	PRIMARY_BEGIN, PRIMARY, PRIMARY_END,
	SECONDARY_BEGIN, SECONDARY, SECONDARY_END,
}

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

signal used()

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

@export var guid: String = "Item"
@export var name: String = "Item"
#@export_multiline var description: String = ""

@export_range(1, ItemStack.MAX) var max_stack: int = ItemStack.MAX
@export var durability: float = -1
@export var texture: Texture

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

func use(_owner: InventoryData, _index: int, _state: int, _target: Node) -> void:
	pass

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
