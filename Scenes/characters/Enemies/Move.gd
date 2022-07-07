extends BTLeaf

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent
	
	#GET
	#self.position += (player.get_position() - self.position) / 50
	#enemy.look_at(enemy.player.get_position())
	enemy.arrive_force(enemy.player.global_position, enemy.MAX_SPEED)
	
	enemy.move_and_collide(enemy.motion*delta)
	
	result.set_success()
	#print("passou no teste")
	
