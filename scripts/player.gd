extends KinematicBody2D

func _ready():
	_draw()
	
func _draw():
	draw_circle(Vector2(512, 300), 20, Color.green)
	get_node("TestBase").position = Vector2(510, 200)

var _velocity := Vector2.ZERO

func _physics_process(_delta) -> void:
	var _hori_directions = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength('move_left')
	)
	_velocity.x = _hori_directions *  10
	_velocity.y += 1400.0 * _delta
	_velocity = move_and_slide(_velocity, Vector2.UP)
