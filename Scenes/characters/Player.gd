extends KinematicBody2D

var movespeed = 400
var bullet = preload("res://Scenes/props/Bullet.tscn")

var recarregado = true
var tempo_recarga = 0.2
var padrao_tempo_recarga = tempo_recarga

var dano = 1
var dano_padrao = dano

var reset_poder = []

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
		var instancia_bala = Global.instance_node(bullet, global_position, Global.criacao_no_pai)
		instancia_bala.dano = dano
		recarregado = false
		$tempo_recarga.start()

func _on_tempo_recarga_timeout():
	recarregado = true
	$tempo_recarga.wait_time = tempo_recarga
	
func _on_tempo_recarga_col_timeout():
	if reset_poder.find("tempo_recarga") != null:
		tempo_recarga = padrao_tempo_recarga
		reset_poder.erase("tempo_recarga")
	if reset_poder.find("dano") != null:
		dano = dano_padrao
		reset_poder.erase("dano")
	
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


