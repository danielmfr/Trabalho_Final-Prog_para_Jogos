extends BTLeaf

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent
	#print("prestes a atirar")
	if enemy.shoot_timer.is_stopped():
		var player = enemy.player_detection_area.player
		enemy.shoot(enemy, player)
		enemy.shoot_timer.start(enemy.shoot_cooldown)
		#print("atirando")
		result.set_success()
	
