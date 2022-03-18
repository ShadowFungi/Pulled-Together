extends StateMachine

func _ready():
	add_state("still")
	add_state("float")
	add_state("connected")

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent.apply_movement()

func _get_transition(delta):
	return null

func _enter_state(new_State, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
