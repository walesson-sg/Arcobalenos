extends Area2D


var portal := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	print("ta na area do portal")
	portal = true


func _on_body_exited(body):
	portal = false

	
func _process(delta):
	if(portal and Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene_to_file("res://Scene/mundo_futurista.tscn")

