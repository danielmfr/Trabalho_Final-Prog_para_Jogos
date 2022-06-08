extends Area2D

const speed = 10
var target
var velocity = Vector2()

func _ready():
	target = get_global_mouse_position()
	velocity -= (position - target).normalized()*speed


func _physics_process(delta):
	#velocity = -(position - target).normalized()
	#velocity = Vector2(30,0)
	position += velocity


func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		queue_free()
	elif "TileMap" in body.name:
		queue_free()
