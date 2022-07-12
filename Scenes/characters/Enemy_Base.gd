extends KinematicBody2D

var motion = Vector2.ZERO
var atordoado = false
export (int) var recuo = 20
export (int) var vida = 3
export (int) var movespeed = 200

func _process(delta):
		if vida <= 0:
			Global.pontos += 10
			queue_free()
			
func moviemto_basico_inimigo(delta):
	#flipar spirte
	if Global.jogador.global_position < self.global_position:
		get_node( "Sprite" ).set_flip_h( true )
	if Global.jogador.global_position > self.global_position:
		get_node( "Sprite" ).set_flip_h( false )
	#innimigo se movimento em direção do player
	if Global.jogador != null and atordoado == false:
		motion = self.global_position.direction_to(Global.jogador.global_position)
		self.global_position += motion * movespeed * delta
	elif atordoado:
		motion = lerp(motion, Vector2.ZERO, 0.3)
		self.global_position += motion * delta
	


	
#quando o inimigo receber dano
func _on_Area2D_area_entered(area):
	if area.is_in_group("dano"):
		print("inimigo acertado")
		vida -= Global.jogador.dano
		motion = -motion * recuo
		atordoado = true
		$timer_recuo.start()

	

func _on_timer_recuo_timeout():
	atordoado = false
 
