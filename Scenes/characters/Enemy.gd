extends KinematicBody2D

var movespeed = 100
var motion = Vector2.ZERO
var vida = 3
var atordoado = false
var recuo = 2

func _physics_process(delta):
	
	#innimigo se movimento em direção do player
	if Global.jogador != null and atordoado == false:
		motion = global_position.direction_to(Global.jogador.global_position)
	global_position += motion * movespeed * delta
	
	#colisão com as paredes
	move_and_collide(motion)
	
	#verificar se o inimigo está morto
	if vida <= 0:
		queue_free()

#quando o inimigo receber dano
func _on_Area2D_area_entered(area):
	print("atingido")
	vida -=1
	motion = -motion * recuo
	atordoado = true
	$timer_recuo.start()
	

func _on_timer_recuo_timeout():
	atordoado = false
 
	
		#var Player = get_path()
		#var player := get_tree().get_root().get_node("Fase").get_node("Player")
		#GET
		#self.position += (player.get_position() - self.position) / 50
		#look_at(player.get_position())

	


#func _on_Area2D_body_entered(body):
	#pass
	#if area.is_in_group("dano"):
	#	area
	#if 'Bullet' in body.name	:
		#print('morreu')
	#	queue_free()



		



