extends KinematicBody2D

var movespeed = 400
var bullet = preload("res://Scenes/props/Bullet.tscn")

var recarregado = true
var morto = false

func _ready():
	Global.jogador = self

func _enter_tree():
	Global.jogador = null

func _physics_process(delta):
	var motion = Vector2()
	if !morto:
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
	
	if Input.is_action_pressed("LMB") and Global.criacao_no_pai != null and recarregado and !morto:
		Global.instance_node(bullet, global_position, Global.criacao_no_pai)
		recarregado = false
		$tempo_recarga.start()

func _on_tempo_recarga_timeout():
	recarregado = true
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		if Global.recorde < Global.pontos:
			Global.recorde = Global.pontos
		visible = false
		morto = true
		print("acertou o player")
		death()

func death():
	Global.pontos = 0
	yield(get_tree().create_timer(1),"timeout")
	get_tree().reload_current_scene()
	


