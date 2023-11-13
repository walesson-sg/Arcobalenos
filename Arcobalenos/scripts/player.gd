extends CharacterBody2D

signal dead

const chutar := preload("res://actors/chutar_moeda.tscn")
const SPEED = 200.0
const JUMP_FORCE = -400.0

@onready var animacao := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
@onready var contador := $moedas_num as Label
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var is_shooting := false
var moeda_disparo := true
var coins = 5



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		animacao.play("jump")
		velocity.y += gravity * delta
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	if Input.is_action_just_pressed("chutar_moeda") and moeda_disparo and coins > 0:
		var moeda_instance = chutar.instantiate()
		coins -= 1
		placar_moedas_reduz()
		if sign($spell_point.position.x) == 1:
			moeda_instance.set_direction(1)
		else:
			moeda_instance.set_direction(-1)
		get_parent().add_child(moeda_instance)
		moeda_instance.position = $spell_point.global_position
		moeda_disparo = false
		$moeda_recarga.start()

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animacao.scale.x = direction
		if !is_jumping:
			animacao.play("run")
		if direction == 1 and sign($spell_point.position.x) == -1:
			$spell_point.position.x *= -1
		if direction == -1 and sign($spell_point.position.x) == 1:
			$spell_point.position.x *= -1
		
	elif is_jumping:
		animacao.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animacao.play("idle")
	if is_shooting:
		animacao.play("spell")
	move_and_slide()


func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		get_tree().reload_current_scene()


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path


func _on_moeda_recarga_timeout():
	moeda_disparo = true


func _on_hurtbox_area_entered(area):
	if area.is_in_group("armadilha"):
		get_tree().reload_current_scene()
		emit_signal("dead")
	elif area.is_in_group("moedas"):
		coins += 3
		placar_moeda_aumenta()
		
func placar_moedas_reduz():
	var aux = int(contador.text)
	aux -= 1
	contador.text = str(aux)
	
func placar_moeda_aumenta():
	var aux = int(contador.text)
	aux += 3
	contador.text = str(aux)
	
	


		
	
