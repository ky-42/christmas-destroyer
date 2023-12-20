extends CharacterBody2D

const damage = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var casts = [$RayCast2D, $RayCast2D2, $RayCast2D3]

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	var destoryed = false
	
	for i: RayCast2D in casts:
		if i.is_colliding():
			var collider = i.get_collider()
			if collider is TileMap:
				var map_collision_pos = collider.local_to_map(i.global_position+i.target_position)
				var a: TileData = collider.get_cell_tile_data(0, map_collision_pos)
				if a:
					var health: int = a.get_custom_data("health")
					if health != -1:
						health -= damage
						if health <= 0:
							collider.set_cell(0, map_collision_pos)

			queue_free()
