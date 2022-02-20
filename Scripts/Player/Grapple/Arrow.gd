extends Node2D


onready var tail := $RayCast2D/Tail
onready var tween : Tween = $Tween
onready var ray : RayCast2D = $RayCast2D
onready var mouse := $MousePos

var posit : Array

func contact():
	mouse.set_global_position(get_global_mouse_position())
	ray.look_at(get_global_mouse_position())
	posit = [position, ray.get_cast_to()]
	if mouse.position.x > self.position.x:
		ray.cast_to.x = -mouse.position.x
	if mouse.position.x >= -250:
		ray.cast_to.x = -mouse.position.x
	else:
		ray.cast_to.x = 250
	tail.set_points(PoolVector2Array(posit))
