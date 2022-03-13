extends StateMachine


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("grapple")
	add_state("grow")
	call_deferred("set_state", states.idle)

func _input(event):
	if [states.idle, states.run].has(state):
		if event.is_action_pressed("jump"):
			parent._velocity.y = parent.jump_strength

func _state_logic(delta):
	parent.apply_movement()
	parent._apply_gravity(delta)

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent._velocity.y < 0:
					return states.jump
				elif parent._velocity.y > 0:
					return states.fall
			elif parent._velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent._velocity.y < 0:
					return states.jump
				elif parent._velocity.y > 0:
					return states.fall
			elif parent._velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent._velocity.y >= 0:
				return states.fall
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent._velocity.y < 0:
				return states.jump
				
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		states.run:
			pass
		states.jump:
			pass
		states.fall:
			pass

func _exit_state(old_state, new_state):
	pass
