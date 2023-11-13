extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var detector := $detector_structures as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $AnimationPlayer as AnimationPlayer
var direction := -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
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


func _on_hitbox_2_area_entered(area):
	if area.name == "chutar_moeda":
		anim.play("ibmachucado")



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ibmachucado":
		queue_free()
