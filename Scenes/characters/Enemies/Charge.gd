extends BTLeaf

var charge_chance = 1
var preparing_charge = false
var charging = false

enum States{
	NOT_CHARGE,
	PREPARING_CHARGE,
	CHARGING
}

var state = States.NOT_CHARGE


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy = blackboard.agent
	"""
	print(enemy.charge_timer.time_left)
	print("charging: ", charging)
	print("preparing charge: ", preparing_charge)
	"""
	
	# Checar caso deva dar charge
	if state == States.NOT_CHARGE:
		var randValue = rand_range(0, 300)
		if randValue <= charge_chance:
			if enemy.charge_timer.is_stopped():
				enemy.charge_timer.start(enemy.charge_time)
				state = States.PREPARING_CHARGE
				result.set_running(self)
		else:
			result.set_failure()
	# Ficar parado carregando a corrida
	elif state == States.PREPARING_CHARGE:
		
		enemy.spawn_charge_particle(enemy)
		
		if enemy.charge_timer.is_stopped():
			enemy.charge_timer.start(enemy.charge_time)
			state = States.CHARGING
			
		result.set_running(self)
	
	# Caso ainda esteja no tempo da corrida
	# Continue corrento e retorne RUNNING
	elif state == States.CHARGING:
		
		if not enemy.charge_timer.is_stopped():
			enemy.seek(enemy.charge_speed)
			enemy.move_and_collide(enemy.motion*delta)
			result.set_running(self)
		# Finalizar a corrida e resetar as flags
		else:
			state = States.NOT_CHARGE
			result.set_success()
		
	
	"""
	if result.is_failed():
		preparing_charge = false
		charging = false
	
	if preparing_charge == false:
		var randValue = rand_range(0, 300)
		#print("timer: ", enemy.charge_timer.time_left)
		
		
		if randValue <= charge_chance:
			#print(randValue)
			#print("avançando")
			preparing_charge = true
			if enemy.charge_timer.is_stopped():
				enemy.charge_timer.start(enemy.charge_time)
				result.set_running(self)
		else:
			result.set_failure()
	
	else:
		# Ficar parado carregando a corrida
		#print("mega bingus")
		enemy.spawn_charge_particle(enemy)
		if charging == false:
			if enemy.charge_timer.is_stopped():
				charging = true
				#print("bingus")
				enemy.charge_timer.start(enemy.charge_time)
			
			
			result.set_running(self)
			
			
		# Passar para esse else: depois de ficar parado
		else:
			# Caso ainda esteja no tempo da corrida
			# Continue corrento e retorne RUNNING
			if not enemy.charge_timer.is_stopped():
				enemy.seek(enemy.player.global_position, enemy.charge_speed)
				enemy.move_and_collide(enemy.motion*delta)
				result.set_running(self)
				
			# Finalizar a corrida e resetar as flags
			else:
				preparing_charge = false
				charging = false
				result.set_success()
				
				
	"""
	
