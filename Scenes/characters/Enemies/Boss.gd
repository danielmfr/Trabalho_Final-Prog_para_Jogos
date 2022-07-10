extends KinematicBody2D

var motion = Vector2.ZERO
var MAX_SPEED = 100
onready var arrive_radius = 50
onready var current_speed = MAX_SPEED

onready var MAX_HEALTH = 10
onready var health = MAX_HEALTH
var recuo = 2
var atordoado = false
# Flag para ativar o comportamento de cura
# Controlado em damage_self()
# E em heal()
onready var health_low = false
onready var health_low_threshold = 4 # Valor que decide quando o boss começa a se curar
onready var health_high_threshold = 6 # Valor que decide quando o boss para de se curar
var heal_time = 0.8 # Valor controla quando tempo cada heal demora
var heal_cooldown = 8.0 # Valor que controla de quanto em quanto tempo demora para poder se curar de novo
onready var heal_timer = $Heal_Timer
onready var heal_sprite = preload("res://Scenes/characters/Enemies/Heal_Particle.tscn")

# Variáveis para o tiro
var bullet = preload("res://Scenes/characters/Enemies/Enemy_Bullet.tscn")
onready var shoot_timer = $Shoot_Timer
onready var shoot_cooldown = 0.8

# Variáveis para a investida
onready var charge_timer = $Charge_Timer
var charge_time = 2 # Tempo para carregar a investida
onready var charge_speed = MAX_SPEED*2
onready var charge_sprite = preload("res://Scenes/characters/Enemies/Charge_Particle.tscn")

onready var player_detection_area = $Area_Close
onready var player := get_tree().get_root().get_node("Fase").get_node("Player")

func _physics_process(delta):	
	if Global.jogador.global_position < global_position:
		get_node( "Sprite" ).set_flip_h( true )
	if Global.jogador.global_position > global_position:
		get_node( "Sprite" ).set_flip_h( false )
			

	

func seek( max_speed):
	if atordoado == false:
		var desired = Global.jogador.global_position - self.global_position
		desired = desired.normalized()
		desired *= max_speed
		var steer = desired - motion
		steer = steer.normalized()
		steer *= max_speed
		apply_motion(steer)
		

func arrive_force(target: Vector2, max_speed):
	var desired = target - global_position
	
	var d = desired.length()
	desired = desired.normalized()
	#print(d)
	
	if d <= arrive_radius:
		var scale = range_lerp(d, 0, 100, 0, max_speed)
		desired *= scale
	else:
		desired *= max_speed
	
	var steer = desired - motion
	#print(steer)
	steer = steer.normalized()
	steer *= max_speed
	apply_motion(steer)

func apply_motion(_motion: Vector2):
	self.motion += _motion

func damage_self(amount):
	health -= amount
	if health <= 0:
		Global.pontos += 70
		queue_free()
	if self.health <= health_low_threshold:
		self.health_low = true


func shoot(spawn_position, target):
	var new_bullet = bullet.instance()
	new_bullet.position = spawn_position.global_position
	new_bullet.damage = 1
	new_bullet.look_at(target.global_position)
	get_parent().add_child(new_bullet)
	return new_bullet

func heal(amount):
	self.health += amount
	spawn_heal_particle(self)
	if self.health >= MAX_HEALTH:
		self.health = MAX_HEALTH
	if self.health > health_high_threshold:
		health_low = false
	return self.health_low
	
func spawn_heal_particle(spawn_position):
	var new_particle = heal_sprite.instance()
	var randVec = Vector2(rand_range(-10, 10), rand_range(-10, 10))
	#print(randVec)
	new_particle.position = spawn_position.global_position + randVec
	new_particle.rotation = spawn_position.rotation
	get_parent().add_child(new_particle)
	
func spawn_charge_particle(spawn_position):
	var new_particle = charge_sprite.instance()
	var randVec = Vector2(rand_range(-10, 10), rand_range(-10, 10))
	#print(randVec)
	new_particle.position = spawn_position.global_position + randVec
	new_particle.rotation = spawn_position.rotation
	get_parent().add_child(new_particle)
	pass

func _on_Death_Area_area_entered(area):
	if area.is_in_group("dano"):
		area.queue_free()
		damage_self(Global.jogador.dano)
		motion = -motion * recuo
		atordoado = true
		$timer_recuo.start()
	

func _on_timer_recuo_timeout():
	atordoado = false
