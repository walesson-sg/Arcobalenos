extends Control


@onready var transicao := $transition as CanvasLayer


func _on_play_pressed(): 
	get_tree().change_scene_to_file("res://Scene/mundo_glacial.tscn")


func _on_controles_pressed():
	get_tree().change_scene_to_file("res://Scene/menu_controles.tscn")
	
	
func _on_sair_pressed():
		get_tree().quit()
