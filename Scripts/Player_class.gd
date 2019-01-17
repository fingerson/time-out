extends Tank

class_name Player

var is_alive = true

func die():
	print("Player_morreu")
	collision_shape.set_disabled(true)
	is_alive = false
	set_process(false)
	hide()

func _ready():
	add_to_group("Player")
	if Engine.editor_hint:
		set_process(false)
	else:
		var camera = Camera2D.new()
		camera.drag_margin_h_enabled = false
		camera.drag_margin_v_enabled = false
		add_child(camera)
		camera.current = true
	#set_process_input(true)
	
	pass

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			shoot()
#	pass
	
func _process(delta):
	var relative_canvas_position = turret.get_global_transform_with_canvas()
	var relative_mouse_position = get_viewport().get_mouse_position() - relative_canvas_position.get_origin()
	turret.rotation = relative_mouse_position.angle() + PI/2 - get_global_transform_with_canvas().get_rotation()
	if Input.is_action_just_pressed("mouse_click"):
		shoot()
		pass
	if Input.is_action_pressed("ui_up"):
		move_forward()
		pass
	if Input.is_action_pressed("ui_down"):
		move_backwards()
		pass
	if Input.is_action_pressed("ui_left"):
		rotate(-1*TURNING_SPEED*delta)
		pass
	if Input.is_action_pressed("ui_right"):
		rotate(TURNING_SPEED*delta)
		pass
	pass