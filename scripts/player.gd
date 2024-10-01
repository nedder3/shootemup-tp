extends CharacterBody2D

var speed: Vector2 = Vector2.ZERO
var acceleration: float = 170.0  # Aceleración del movimiento
var deceleration: float = 2.8  # Deceleración cuando se suelta la tecla

var pre_bullet = preload("res://escenas/bullet.tscn")

func _physics_process(_delta: float) -> void:
	# Manejar la entrada del jugador
	if Input.is_action_pressed("d"):
		speed.x = acceleration
	elif Input.is_action_pressed("a"):
		speed.x = -acceleration
	if Input.is_action_pressed("spacebar"):
		shoot()
	else:
		# Decelerar cuando no se presionan las teclas
		speed.x = lerp(speed.x, 0.0, deceleration * _delta)

	# Mover la nave
	velocity = speed  # Asignar la velocidad antes de mover
	move_and_slide()  # Llamada a la función sin argumentos

var readyToShoot: bool = true

func shoot() -> void:
	if readyToShoot == true:
		var bullet = pre_bullet.instantiate()
		get_parent().call_deferred("add_child", bullet)
		bullet.position = self.position  # Asignar la posición de la bala
		readyToShoot = false
		await get_tree().create_timer(1).timeout
		readyToShoot = true
