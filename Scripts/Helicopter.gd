extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var targets = []

func _ready():
	$AnimationPlayer.current_animation = "transition"
	pass

func _process(delta):
	targets = []
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			targets.append(node)
	if len(targets) >= 1:
		var closest = misc_funcs.get_closest(self,targets)
		rotation = (closest.get_global_position() - get_global_position()).angle()
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
