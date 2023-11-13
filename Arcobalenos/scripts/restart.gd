extends MarginContainer

var cena: String

func getCena(cena_atual):
	cena = cena_atual

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_recomecar_pressed():
	get_tree().change_scene_to_file(cena)
