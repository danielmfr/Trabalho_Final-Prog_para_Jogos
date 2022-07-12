extends KinematicBody2D

var movespeed = 400
var bullet = preload("res://Scenes/props/Bullet.tscn")

var recarregado = true
var tempo_recarga = 0.2
var padrao_tempo_recarga = tempo_recarga

var dano = 1
var dano_padrao = dano

var health = 3
var health_padrao = health

var invincibility = false
var invincibility_cooldown = 1.2
onready var invincibility_timer = $Invincibility_Timer
onready var invincibility_particle = preload("res://Scenes/characters/Invincibility_Particle.tscn")

var reset_poder = []

var morto = false

func _ready():
	Global.jogador = self

func _enter_tree():
	Global.jogador = null
	
func _process(delta):
	if health == 3:
		Global.vidas = "F F F"

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
	
#retornar os atributos do jogador no final do tempo de efeito do upgrade
func _on_tempo_recarga_col_timeout():
	if reset_poder.find("tempo_recarga") != null:
		tempo_recarga = padrao_tempo_recarga
		reset_poder.erase("tempo_recarga")
	if reset_poder.find("dano") != null:
		dano = dano_padrao
		reset_poder.erase("dano")
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		if !invincibility:
			health -= 1
			if health == 2:
				Global.vidas = "F F"
			elif health == 1:
				Global.vidas = "F"
			invincibility = true
			$Invincibility_Timer.start(invincibility_cooldown)
			spawn_invincibility_particles(self)
			if health <= 0:
				Global.vidas = " "
				visible = false
				morto = true
				death()


		print("acertou o player")

func spawn_invincibility_particles(spawn_position):
	for i in range(5):
		var new_particle = invincibility_particle.instance()
		var randVec = Vector2(rand_range(-50, 50), rand_range(-50, 50))
		new_particle.position = Vector2(0, 0) + randVec
		#new_particle.look_at(target.global_position)
		add_child(new_particle)

func death():
	if Global.recorde < Global.pontos:
		Global.recorde = Global.pontos
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene("res://Scenes/levels/Game_Over.tscn")

func _on_Invincibility_Timer_timeout():
	invincibility = false
