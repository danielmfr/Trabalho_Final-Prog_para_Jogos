extends Control


func _on_voltar_menu_pressed():
	get_tree().change_scene("res://Scenes/levels/MainMenu.tscn")

func _on_tentar_novamente_pressed():
	get_tree().change_scene("res://Scenes/levels/Phase1.tscn")
