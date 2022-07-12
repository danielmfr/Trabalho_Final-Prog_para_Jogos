extends BTLeaf

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent

	enemy.arrive_force(enemy.player.global_position, enemy.MAX_SPEED)
	
	enemy.move_and_collide(enemy.motion*delta)
	
	result.set_success()

	
