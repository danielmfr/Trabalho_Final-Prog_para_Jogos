extends Sprite

export(String) var modificador_variavel_jogador
export(float) var valor_variavel_jogador

export(float) var tempo_recarga_poder = 4

#infelizmente para poder alterar os atributos do player apelamos por acessar direntamente esse atributo dele
func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		$SomUpgrade.play()
		area.get_parent().set(modificador_variavel_jogador,valor_variavel_jogador)
		area.get_parent().get_node("tempo_recarga_col").wait_time = tempo_recarga_poder
		area.get_parent().get_node("tempo_recarga_col").start()
		area.get_parent().reset_poder.append(name)
		queue_free()
