tool
extends Area2D
# Detects and returns the best snapping target for the hook


onready var ray_cast: RayCast2D = $RayCast2D


func _ready() -> void:
	if Engine.editor_hint:
		set_physics_process(false)
	ray_cast.set_as_toplevel(true)


# Returns the length of the hook, from the origin to the tip of the collision shape
# Used to draw the hook's radius in the editor
func calculate_length() -> float:
	var length := -1.0
	for collider in [$CapsuleH, $CapsuleV]:
		if not collider:
			continue
		var capsule: CapsuleShape2D = collider.shape
		var capsule_length: float = collider.position.length() + capsule.height / 2 * sin(collider.rotation) + capsule.radius
		length = max(length, capsule_length)
	return length
