tool
extends KinematicBody2D

class_name Tank
var turret
var shot_pos
var shot_timer
var move_pos
var collision_shape
var BULLET = load("res://Scenes/Bullet.tscn")

export(float) var SHOT_DELAY = 1.0
export(int) var SPEED = 100
export(float) var TURNING_SPEED = PI/2
export(int) var HIT_POINTS = 10

var can_die = true
var can_shoot = true

func take_damage(damage_taken):
	if can_die:
		HIT_POINTS -= damage_taken
		print("ai")
		if HIT_POINTS <= 0:
			die()
	pass

func die():
	print("Morri")
	queue_free()

func change_shot_dalay(val):
	shot_timer.wait_time = val
	SHOT_DELAY = val

func _enter_tree():
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(22,22)
	add_child(collision_shape)
	var tank_sprite = Sprite.new()
	tank_sprite.texture = load("res://Graphics/Sprites/Tank/Tank.png")
	tank_sprite.rotation = (deg2rad(180))
	tank_sprite.scale = Vector2(0.25,0.25)
	add_child(tank_sprite)
	turret = Position2D.new()
	turret.name = "Turret"
	add_child(turret)
	var turret_sprite = Sprite.new()
	turret_sprite.z_index = 1
	turret_sprite.scale = Vector2(0.25,0.25)
	turret_sprite.texture = load("res://Graphics/Sprites/Tank/GunTurret.png")
	turret_sprite.position = Vector2(0,-9)
	turret.add_child(turret_sprite)
	shot_pos = Position2D.new()
	shot_pos.position = Vector2(0,-25)
	turret.add_child(shot_pos)
	move_pos = Position2D.new()
	move_pos.position = Vector2(0,-1)
	add_child(move_pos)
	shot_timer = Timer.new()
	shot_timer.one_shot = true
	shot_timer.wait_time = SHOT_DELAY
	add_child(shot_timer)
	shot_timer.connect("timeout", self, "_shot_cooldown_timeout")
	pass
func shoot():
	if can_shoot:
		var bullet = BULLET.instance()
		bullet.parent_name = get_name()
		bullet.rotation = turret.get_global_transform_with_canvas().get_rotation()
		bullet.global_position = shot_pos.global_position
		bullet.speed = (shot_pos.global_position-turret.global_position).normalized()
		print("bam")
		get_parent().add_child(bullet)
		can_shoot = false
		shot_timer.start()
	pass

func move_forward(modifier = 1):
	var motion = (move_pos.global_position - global_position).normalized()
	move_and_slide(motion*SPEED*modifier)
	pass

func move_backwards():
	var motion = (move_pos.global_position - global_position).normalized()
	move_and_slide(-1*motion*SPEED)
	pass

func _shot_cooldown_timeout():
	can_shoot = true
	pass