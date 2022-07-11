extends "res://Scenes/characters/Enemy_Base.gd"

func _physics_process(delta):
	moviemto_basico_inimigo(delta)

	#colisão com as paredes
	move_and_collide(motion)

	
