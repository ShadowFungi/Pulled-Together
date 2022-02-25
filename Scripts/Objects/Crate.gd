extends Node2D

onready var CT = $ConnectPointTop
onready var CR = $ConnectPointRight
onready var CB = $ConnectPointBottom
onready var CL = $ConnectPointLeft

var nod : NodePath

func _on_CTArea2D_body_entered(_body):
	CT.set_node_a(get_parent().get_node("Player").get_path())
	CT.set_node_b(self.get_path())
	print("CT/" + CT.node_a)


func _on_CRArea2D_body_entered(_body):
	CR.set_node_a(get_parent().get_node("Player").get_path())
	CR.set_node_b(self.get_path())
	print("CR/" + CR.node_a)


func _on_CBArea2D_body_entered(_body):
	CB.set_node_a(get_parent().get_node("Player").get_path())
	CB.set_node_b(self.get_path())
	print("CB/" + CB.node_a)


func _on_CLArea2D_body_entered(_body):
	CL.set_node_a(get_parent().get_node("Player").get_path())
	CL.set_node_b(self.get_path())
	print("CL/" + CL.node_a)
