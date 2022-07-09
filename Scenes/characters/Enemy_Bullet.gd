extends Area2D

const speed = 600
onready var velocity = Vector2(1,0)
onready var direction = Vector2(1, 0)
var damage = 1

func _physics_process(delta):
	global_position += velocity.rotated(rotation)*speed*delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
	if !body.is_in_group("enemy"):
		queue_free()
