extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVESPEED = 50
const ROTATESPEED = PI/5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_to_group("Player")
	pass

func _process(delta):
	var motion = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		motion = $Move.global_position - global_position
	elif Input.is_action_pressed("ui_down"):
		motion = ($Move.global_position - global_position) *-1
	if Input.is_action_pressed("ui_left"):
		rotate(ROTATESPEED*delta*-1)
	if Input.is_action_pressed("ui_right"):
		rotate(ROTATESPEED*delta)
	move_and_slide(motion * MOVESPEED)
	pass
