extends Area2D

const SPEED := 300

var velocity := Vector2.ZERO
var direction := 1

func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir
	if direction == 1:
		$Anim.flip_h = false
	else:
		$Anim.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)

func _on_visibility_screen_exited():
	queue_free()

func _on_body_entered(body):
	queue_free()
