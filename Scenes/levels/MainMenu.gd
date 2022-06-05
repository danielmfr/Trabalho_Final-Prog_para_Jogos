extends Control

func _ready():
	pass # Replace with function body.


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/levels/Phase1.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/levels/Controls.tscn")


func _on_Quit_pressed():
	get_tree().quit()
