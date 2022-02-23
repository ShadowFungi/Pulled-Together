extends Node2D

onready var CT = $ConnectPointTop
onready var CR = $ConnectPointRight
onready var CB = $ConnectPointBottom
onready var CL = $ConnectPointLeft

var nod : NodePath

func _on_CTArea2D_body_entered(body):
	CT.set_node_a(NodePath("Player"))
	CT.set_node_b(NodePath("Crate"))
	print("CT/" + CT.node_a)


func _on_CRArea2D_body_entered(body):
	CR.set_node_a(NodePath("Player"))
	CR.set_node_b(NodePath("Crate"))
	print("CR/" + CR.node_a)


func _on_CBArea2D_body_entered(body):
	CB.set_node_a(NodePath("Player"))
	CB.set_node_b(NodePath("Crate"))
	print("CB/" + CB.node_a)


func _on_CLArea2D_body_entered(body):
	CL.set_node_a(NodePath("Player"))
	CL.set_node_b(NodePath("Crate"))
	print("CL/" + CL.node_a)
