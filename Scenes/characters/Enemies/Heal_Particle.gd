extends Sprite

func _on_Expire_Timer_timeout():
	queue_free()
