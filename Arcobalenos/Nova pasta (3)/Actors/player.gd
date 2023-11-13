extends CharacterBody2D

var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
const pulo_vel = -400

var velocidade = 200
var motion = Vector2()
var movimento = Vector2(0, 1)
var controlador = {
	'up': false,
	'down': false,
	'left': false,
	'right': false,
	'jump': false
}

func _physics_process(delta):
	
	controll_loop()
	movement_loop(delta)

func controll_loop():
	self.controlador['up'] = Input.is_action_pressed('ui_up')
	self.controlador['down'] = Input.is_action_pressed('ui_down')
	self.controlador['left'] = Input.is_action_pressed('ui_left')
	self.controlador['right'] = Input.is_action_pressed('ui_right')

func movement_loop(delta):
		update_direction()
		update_animation()
		
		motion = (movimento * velocidade) * delta
		
		movimentacao(delta)

func update_direction():
	movimento.x = -int(self.controlador['left']) + int(self.controlador['right']) 
	movimento.y = -int(self.controlador['up']) + int(self.controlador['down'])

func update_animation():
	if movimento.x != 0:
		$AnimatedSprite2D.play("correndo")
		if movimento.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("parado")
				
func movimentacao(delta):
	if not is_on_floor():
		velocity.y += gravidade * delta
		if velocity.y > 0:
			$AnimatedSprite2D.play("caindo")
		else:
			$AnimatedSprite2D.play("pulando")

	if Input.is_action_just_pressed('ui_up') and is_on_floor():
		velocity.y = pulo_vel

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * velocidade
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)

	move_and_slide() 
