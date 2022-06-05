extends RigidBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		queue_free()
	elif "TileMap" in body.name:
		queue_free()
