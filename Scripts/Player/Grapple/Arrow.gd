extends Node2D


onready var tail := $RayCast2D/Tail
onready var tween : Tween = $Tween
onready var ray : RayCast2D = $RayCast2D
onready var mouse := $MousePos

var posit : Array

func contact():
	mouse.set_global_position(get_global_mouse_position())
	if mouse.position.x > 0:
		if mouse.position.x < 250:
			ray.cast_to = mouse.position
		else:
			ray.cast_to = mouse.position
			while ray.cast_to.x > 250:
				ray.cast_to.x -= 1
	elif mouse.position.x < 0:
		if mouse.position.x > -250:
			ray.cast_to = mouse.position
		else:
			ray.cast_to = mouse.position
			while ray.cast_to.x < -250:
				ray.cast_to.x += 1
	if mouse.position.y > 0:
		if mouse.position.y < 250:
			ray.cast_to = mouse.position
		else:
			ray.cast_to = mouse.position
			while ray.cast_to.y > 250:
				ray.cast_to.y -= 1
	elif mouse.position.y < 0:
		if mouse.position.y > -250:
			ray.cast_to = mouse.position
		else:
			ray.cast_to = mouse.position
			while ray.cast_to.y < -250:
				ray.cast_to.y += 1
	else:
		ray.cast_to = mouse.position
		while ray.cast_to.x < -250:
			ray.cast_to.x += 1
		while ray.cast_to.y < -250:
			ray.cast_to.y += 1
	posit = [position, ray.get_cast_to()]
	tail.set_points(PoolVector2Array(posit))
