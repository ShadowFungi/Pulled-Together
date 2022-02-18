extends KinematicBody2D

func _ready():
	draw_circle(Vector2(512, 300), 10, Color.green)
	get_node("CollisionShape2D").position.x = Vector2(512,300)
