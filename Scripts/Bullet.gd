extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SPAN = 5
const SPEEDVAL = 250
var speed = Vector2(0,0)
onready var time = 0

func _ready():
	$Area2D.connect("body_entered",self,"_on_body_entered")
	pass

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		queue_free()
	pass

func _process(delta):
	position += (SPEEDVAL*speed*delta)
	time += delta
	if time > SPAN:
		queue_free()
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
