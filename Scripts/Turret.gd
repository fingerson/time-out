extends Position2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var BULLET = load("res://Scenes/Bullet.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_process_input(true)
	pass
	
func fire():
	var bullet = BULLET.instance()
	bullet.rotation = get_global_transform_with_canvas().get_rotation()
	bullet.global_position = $Bullet_pos.global_position
	bullet.speed = ($Bullet_pos.global_position-global_position).normalized()
	print("bam")
	get_parent().get_parent().add_child(bullet)
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			fire()
	pass

func _process(delta):
	var relative_canvas_position = get_global_transform_with_canvas()
	var relative_mouse_position = get_viewport().get_mouse_position() - relative_canvas_position.get_origin()
	rotation = relative_mouse_position.angle() + PI/2 - get_parent().get_global_transform_with_canvas().get_rotation()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
