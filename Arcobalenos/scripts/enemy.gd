extends CharacterBody2D


const SPEED = 1500.0
const JUMP_VELOCITY = -400.0

@onready var detector := $detector_structures as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
var skeletonLife := 3
var direction := -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if detector.is_colliding():
		direction *= -1
		detector.scale.x *= -1
	
	if direction == -1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	velocity.x = direction * SPEED * delta

	move_and_slide()

func _on_anim_animation_finished(anim_name: StringName):
	if anim_name == "tomouDano":
		anim.play("walk")
	if anim_name == "dead":
		queue_free()
		

func _on_hitbox_2_area_entered(area):
	if area.name == "chutar_moeda":
		skeletonLife -= 1
		anim.play("tomouDano")
	if skeletonLife < 1:
		SPEED == 0.0
		anim.play("dead")


func _on_ready():
	anim.play("walk") # Replace with function body.
