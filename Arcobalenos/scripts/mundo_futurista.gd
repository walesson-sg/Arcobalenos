extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player.follow_camera(camera)
	player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
