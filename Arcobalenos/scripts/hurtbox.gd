extends Area2D


func _on_area_entered(area):
	if area.name == "area_limite":
		print("faliceu e fez pose")
		owner.anim.play("dead")

