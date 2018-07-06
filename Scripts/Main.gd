extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var TITLE = load("res://Scenes/Title.tscn")

func _ready():
	var title = TITLE.instance()
	title.connect("out_mode",self,"title_option")
	add_child(title)
	pass

func title_option(option):
	if option == "ng":
		pass
	elif option == "quit":
		get_tree().quit()
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
