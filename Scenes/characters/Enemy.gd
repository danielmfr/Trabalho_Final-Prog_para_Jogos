extends KinematicBody2D

var motion = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	#var Player = get_path()
	var player := get_tree().get_root().get_node("Fase").get_node("Player")
	#GET
	self.position += (player.get_position() - self.position) / 50
	look_at(player.get_position())

	move_and_collide(motion)


func _on_Area2D_body_entered(body):
	if 'Bullet' in body.name:
		print('morreu')
		queue_free()
