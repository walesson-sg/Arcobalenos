extends CanvasLayer

signal start_game

@onready var animation = get_node("animation")

var target_level: String

func fade_in(level : String):
	target_level = level
	animation.play("transition_in")
	
	
func _on_animation_finished(anim_name):
	if anim_name == "transition_in":
		get_tree().change_scene_to_file(target_level)
		animation.play("transition_out")
	elif anim_name == "transition_out":
		emit_signal("start_game")
