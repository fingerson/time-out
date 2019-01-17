extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var damage = 5
const SPAN = 5
const SPEEDVAL = 600
var speed = Vector2(0,0)
onready var time = 0
var parent_name

func _ready():
	$Area2D.connect("body_entered",self,"_on_body_entered")
	pass

func _on_body_entered(body):
	if not body.get_name() == parent_name:
		if body.has_method("take_damage"):
			body.take_damage(damage)
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
