extends Node2D


onready var tail := $RayCast2D/Tail
onready var tween : Tween = $Tween
onready var ray : RayCast2D = $RayCast2D
onready var mouse := $RayCast2D/MousePos
onready var con := $RayCast2D/Connect

var posit : Array

func contact():
	mouse.set_global_position(get_global_mouse_position())
	ray.cast_to = mouse.position
	posit = [position, ray.get_cast_to()]
	con.position = ray.cast_to
	tail.set_points(PoolVector2Array(posit))
