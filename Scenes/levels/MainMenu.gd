extends Control

func _ready():
	HUD.get_child(0).hide()

func _on_Play_pressed():
	HUD.get_child(0).show()
	get_tree().change_scene("res://Scenes/levels/Phase1.tscn")
	

func _on_Controles_pressed():
	get_tree().change_scene("res://Scenes/levels/Controls.tscn")


func _on_TextureButton_pressed():
	get_tree().quit()
