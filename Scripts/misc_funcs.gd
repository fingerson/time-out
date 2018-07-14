extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func get_closest(object, list):
	if len(list) == 0:
		return
	var closest = list[0]
	var lesser_distance = object.get_global_position() - list[0].get_global_position()
	lesser_distance = sqrt(lesser_distance.x*lesser_distance.x+lesser_distance.y*lesser_distance.y)
	for i in range(1,len(list)):
		var distance = object.get_global_position() - list[i].get_global_position()
		distance = sqrt(distance.x*distance.x+distance.y*distance.y)
		if distance < lesser_distance:
			lesser_distance = distance
			closest = list[i]
	return closest