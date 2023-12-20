extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var vel : Vector2 = (get_global_mouse_position() - global_position)
	if vel.length() > 100:
		vel = vel.normalized() * 100
	velocity = vel
	move_and_slide()

# https://www.youtube.com/watch?v=3ed5d2_x4Tk
