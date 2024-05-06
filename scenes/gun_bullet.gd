extends CharacterBody2D

const SPAWN_OFFSET: int = 25 # px?

var INITIAL_SPEED = 2000.0
@export var direction : Vector2

func _ready():
	position += SPAWN_OFFSET * direction
	

func _physics_process(delta):
	var probitie = move_and_collide(direction * INITIAL_SPEED * delta)
	if probitie:
		# пуля столкнулась с чем-то
		pass
		
	move_and_slide()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
