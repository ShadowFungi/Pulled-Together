extends RigidBody2D


const WALK_ACCEL = 550.0
const WALK_DEACCEL = 550.0
const WALK_MAX_VELOCITY = 190.0
const AIR_ACCEL = 150.0
const AIR_DEACCEL = 150.0
const JUMP_VELOCITY = 250
const STOP_JUMP_FORCE = 450.0
const MAX_SHOOT_POSE_TIME = 0.3
const MAX_FLOOR_AIRBORNE_TIME = 0.15

var anim = ""
var siding_left = false
var jumping = false
var stopping_jump = false
var shooting = false

var floor_h_velocity = 0.0

var airborne_time = 1e20
var shoot_time = 1e20

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	var new_anim = anim
	var new_siding_left = siding_left
	
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	lv.x -= floor_h_velocity
	floor_h_velocity = 0.0
	
	var found_floor = false
	var floor_index = -1
	
	for x in range(s.get_contact_count()):
		var ci = s.get_contact_local_normal(x)
	
		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
	
	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time += step
	
	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	
	if jumping:
		if lv.y > 0:
			jumping = false
		elif not jump:
			stopping_jump = true
			
		if stopping_jump:
			lv.y += STOP_JUMP_FORCE * step
			
	if on_floor:
		if move_left and not move_right:
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= WALK_ACCEL * step
		elif move_right and not move_left:
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += WALK_ACCEL * step
		else:
			var xv = abs(lv.x)
			xv -= WALK_DEACCEL * step
			if xv < 0:
				xv = 0
			lv.x = sign(lv.x) * xv
			
		if not jumping and jump:
			lv.y = -JUMP_VELOCITY
			jumping = true
			stopping_jump = false
			
		if lv.x < 0 and move_left:
			new_siding_left = true
		elif lv.x > 0 and move_right:
			new_siding_left = false
		if jumping:
			new_anim = "jumping"
		elif abs(lv.x) < 0.1:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "idle_weapon"
			else:
				new_anim = "idle"
		else:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "run_weapon"
			else:
				new_anim = "run"
	else:
		if move_left and not move_right:
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= AIR_ACCEL * step
		elif move_right and not move_left:
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += AIR_ACCEL * step
		else:
			var xv = abs(lv.x)
			xv -= AIR_DEACCEL * step
			
			if xv < 0:
				xv = 0
			lv.x = sign(lv.x) * xv
			
		if lv.y < 0:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "jumping_weapon"
			else:
				new_anim = "jumping"
		else:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "falling_weapon"
			else:
				new_anim = "falling"
				
	if new_siding_left != siding_left:
		siding_left = new_siding_left
		
	if new_anim != anim:
		anim = new_anim
		
	if found_floor:
		floor_h_velocity = s.get_contact_collider_velocity_at_position(floor_index).x
		lv.x += floor_h_velocity
		
	lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)


func _input(event):
	if Input.is_action_just_pressed("grapple"):
		$Arrow.contact()
