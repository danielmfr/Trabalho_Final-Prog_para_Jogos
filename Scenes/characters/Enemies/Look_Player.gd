extends BTLeaf

# Fazer o inimigo se virar para o jogador

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent

	enemy.look_at(enemy.player.get_position())
