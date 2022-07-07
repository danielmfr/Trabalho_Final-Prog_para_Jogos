extends BTLeaf

var started = false

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent
	#enemy.heal_timer.start(enemy.heal_cooldown)
	result.set_success()
	
	"""
	if !started:
		enemy.heal_timer.start(enemy.heal_cooldown)
		started = true
		result.set_running(self)
	else:
		if enemy.heal_timer.is_stopped():
			result.set_sucess()
		else:
			result.set_running(self)
	
	"""
	pass
