extends KinematicBody2D

var movespeed = 500
onready var bullet = preload("res://Scenes/props/Bullet.tscn")

func _ready():
	pass

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		get_node( "Sprite" ).set_flip_h( true )
		motion.x -= 1
	if Input.is_action_pressed("right"):
		get_node( "Sprite" ).set_flip_h( false )
		motion.x += 1 
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if Input.is_action_just_pressed("LMB"):
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	get_parent().add_child(bullet_instance)
	
	
func death():
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if 'Enemy' in body.name:
		death()
