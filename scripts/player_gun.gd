extends Sprite2D

const BULLET_SHOT = preload("res://scenes/gun_bullet.tscn")
@onready var player = $".."
@onready var body = %Body
@onready var shot_timer = $ShotTimer

const BULLET_PER_MINUTE : float = 700.0
const SHOT_RECOIL : float = 10.0
const REPULSIVE_DISTANCE : float = 2.0

@export_category("hand_smoothing")
@export_range(1, 100) var smoothing_distance : int = 8
@export var HANDS_RELAX_OFFSET : Vector2 = Vector2(0.0, 6.0)


func shot():
	var bullet = BULLET_SHOT.instantiate()
	var shot_direction = Vector2(get_global_mouse_position() - global_position).normalized()
	bullet.direction = shot_direction
	bullet.position = global_position
	# Поворот пули вместе с оружием
	bullet.global_rotation = transform.get_rotation()
	add_child(bullet)
	# add recoil also
	position -= shot_direction * SHOT_RECOIL
	

func hands_smoothing():
	var hands_position : Vector2
	var weight : float = float(smoothing_distance) / 100
	hands_position = lerp(position, body.global_position + HANDS_RELAX_OFFSET, weight)
	position = hands_position.floor()

func _process(delta):
	# our gun looks at the mouse position
	look_at(get_global_mouse_position())
	if get_global_mouse_position()[0] <= global_position.x:
		flip_v = true
	else:
		flip_v = false
		
		# shot em
	if Input.is_action_pressed("player_shot") and shot_timer.is_stopped():
		shot()
		var shot_gap = 60 / BULLET_PER_MINUTE
		shot_timer.start(shot_gap)
		
func _physics_process(delta):
	hands_smoothing()
	
