extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var new_game = preload("res://Scenes/test_level.tscn")

func _ready():
	$New_game.connect("button_down",self,"on_ng")
	$Exit.connect("button_down",self,"on_quit")
	pass

func on_ng():
	get_tree().change_scene_to(new_game)
	
func on_quit():
	get_tree().quit()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
