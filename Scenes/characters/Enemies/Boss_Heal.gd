extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent
	if enemy.heal_timer.is_stopped():
		var low_health = enemy.heal(1)
		#print(enemy.health)
		if low_health:
			enemy.heal_timer.start(enemy.heal_time)
			result.set_running(self)
			
		else:
			enemy.heal_timer.start(enemy.heal_cooldown)
			result.set_success()
	else:
		result.set_running(self)
