extends Camera2D

@export_category("Follow Character")
@export var player : CharacterBody2D
@export_range(1, 20) var focus_distance : float = 14.0

@export_category("Camera Smoothing")
@export var smoothing_enabled : bool
@export_range(1, 20) var smoothing_distance : int = 8


func _physics_process(delta):
	if player != null:
		var camera_position : Vector2
		

		if smoothing_enabled:
			var weight : float = float(smoothing_distance) / 100
			var focus_point = lerp(player.global_position, get_global_mouse_position(), (focus_distance)/100)
			
			# camera_position = lerp(global_position, player.global_position, weight)
			camera_position = lerp(global_position, focus_point, weight)
		else:
			camera_position = player.global_position
		
		global_position = camera_position.floor()
