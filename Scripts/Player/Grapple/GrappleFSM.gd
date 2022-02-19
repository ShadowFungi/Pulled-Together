extends StateMachine


func _state_logic(delta):
	add_state("aim")
	add_state("shot")
	call_deferred("set_state", states.sleep)

func _get_transition(delta):
	return null

func _enter_state(new_State, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
