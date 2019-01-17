extends Navigation2D

export(float) var CHARACTER_SPEED = 400.0
var path = []

# The 'click' event is a custom input action defined in
# Project > Project Settings > Input Map tab

func _ready():
	for child in get_children():
		if child.is_in_group("Enemy"):
			child.player = $Player

func _input(event):
	if event.is_action_pressed("mouse_click"):
		pass
	#_update_navigation_path($Enemy.position, get_local_mouse_position())