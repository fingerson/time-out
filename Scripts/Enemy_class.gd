tool
extends Tank

class_name Enemy

enum states {PATROLLING, INVESTIGATING}

export(float) var TURRET_TURNING_SPEED = PI
export(bool) var PATH_LOOP = false
export(int) var VIEW_DISTANCE = 500
var direction = 1
var patrol_points
var patrol_index = 1
var target
var has_patrol = false

var state = states.PATROLLING
var seeing_player = false

var last_player_position = Vector2(0,0)
var player
var player_check

#var label

func _ready():
	#label = Label.new()
	#label.get_rect().position.x = 20
	#add_child(label)
	if Engine.editor_hint:
		set_process(false)
		pass
	add_to_group("Enemy")
	player_check = RayCast2D.new()
	player_check.enabled = true
	player_check.set_exclude_parent_body(true)
	add_child(player_check)
	for child in get_children():
		if child.get_name() == "Path2D":
			patrol_points = child.get_curve().get_baked_points()
			has_patrol = true
			for point in patrol_points:
				point += position
			pass
	if Engine.editor_hint:
		set_process(false)
		pass
	else:
		set_physics_process(true)
	pass
	
func _physics_process(delta):
	check_for_player(delta)
	get_target()
	var fwd_vec = (move_pos.global_position - global_position).normalized()
	var target_vec = (target-position).normalized()
	var angle = fwd_vec.angle_to(target_vec)
	if fwd_vec.dot(target_vec) >= 0.98:
		move_forward()
	else:
		#move_forward(0.2)
		if angle > 0 and angle < PI:
			rotate(TURNING_SPEED*delta)
		else:
			rotate(-TURNING_SPEED*delta)
	pass

func get_target():
	if state == states.PATROLLING:
		if has_patrol:
			var n_points = patrol_points.size()
			if position.distance_to(patrol_points[patrol_index]) <= 5:
				patrol_index+=direction
				if patrol_index < 0:
					if PATH_LOOP:
						patrol_index = n_points-1
					else:
						patrol_index = 1
						direction*=-1
				if patrol_index >= n_points:
					if PATH_LOOP:
						patrol_index = 0
					else:
						patrol_index = n_points-2
						direction*= -1
			target = patrol_points[patrol_index]
			pass
	pass
	
func check_for_player(delta):
	seeing_player = false
	if player != null and player.is_alive:
		player_check.set_cast_to(((player.get_global_position()-get_global_position()).rotated(-get_global_rotation())).normalized()*VIEW_DISTANCE)
		if player_check.is_colliding():
			if player_check.get_collider() == player:
				var fov = player_check.get_cast_to().angle()-turret.rotation + PI/2
				if (fov > PI):
					fov -= 2*PI
				elif (fov < -PI):
					fov += 2*PI
				if fov <= PI/2 and fov > -PI/2:
					seeing_player = true
					print("Saw Player")
					last_player_position = player.position
					#label.text = str(rad2deg(fov)) + ", "+str(rad2deg(turret.rotation))
					if fov > 0:
						turret.rotate(TURRET_TURNING_SPEED*delta)
					else:
						turret.rotate(-1*TURRET_TURNING_SPEED*delta)
					if fov > -1*PI/36 and fov < PI/36:
						shoot()
	if not seeing_player:
		if turret.rotation < 0:
			turret.rotate(TURRET_TURNING_SPEED*delta)
		else:
			turret.rotate(-1*TURRET_TURNING_SPEED*delta)
		pass
	pass