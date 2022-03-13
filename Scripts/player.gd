extends KinematicBody2D


var _velocity := Vector2.ZERO

func _physics_process(_delta) -> void:
	var _hori_directions = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength('move_left')
		)
	_velocity.x =  _hori_directions *  10
	_velocity.y += 1800.0 * _delta
	_velocity = move_and_slide(_velocity, Vector2.UP)
