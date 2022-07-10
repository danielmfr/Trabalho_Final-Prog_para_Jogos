extends Area2D

const speed = 800
var dir_unica = true
var velocity = Vector2(1,0)

var dano

func _physics_process(delta):
	if dir_unica:
		look_at(get_global_mouse_position())
		dir_unica = false
	global_position += velocity.rotated(rotation) * speed * delta

func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		queue_free()
	elif "TileMap" in body.name:
		queue_free()

