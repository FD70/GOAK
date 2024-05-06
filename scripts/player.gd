extends CharacterBody2D

@onready var body = $Body

const GRAVITY = 980.0
const SPEED = 300.0
const WING_SPEED = 500.0
const JUMP_VELOCITY = -322.0


func _process(delta):
	if get_global_mouse_position()[0] <= global_position.x:
		body.flip_h = true
	else:
		body.flip_h = false


func _physics_process(delta):
	
	if not is_on_floor():
		if Input.is_action_pressed("player_jump"):
			velocity.y = velocity.y - WING_SPEED * delta
		else:
			velocity.y += GRAVITY * delta


	if is_on_floor() and Input.is_action_just_pressed("player_jump"):
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
