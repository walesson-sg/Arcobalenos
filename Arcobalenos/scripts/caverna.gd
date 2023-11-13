extends Area2D

var on_caverna := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	on_caverna = true


func _on_body_exited(body):
	on_caverna = false

	
func _process(delta):
	if(on_caverna and Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene_to_file("res://Scene/mundo_glacial_part2.tscn")
