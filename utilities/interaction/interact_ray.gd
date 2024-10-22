# interact_ray.gd
class_name InteractRay extends RayCast3D

func _ready() -> void:
	add_exception(owner)

func _physics_process(_delta) -> void:
	UI.hud.interact_label.text = ""
	if is_colliding():
		var detected = get_collider()
		if detected is Interactable:
			UI.hud.interact_label.text = detected.get_prompt()
			if Input.is_action_just_pressed(detected.prompt_action):
				detected.interact(owner)
