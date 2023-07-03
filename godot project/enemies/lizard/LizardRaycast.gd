extends RayCast2D

@export var _raycast_range = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(50, 100))
	var result = space_state.intersect_ray(query)
	_adjust_direction()

	
func _adjust_direction():
	var parent = get_parent()
	var parent_vector = Vector2(abs(parent.velocity.x), abs(parent.velocity.y))
	if parent.velocity.x < 0:
		if parent_vector.x > parent_vector.y:
			target_position = Vector2(-_raycast_range, 0)
	if parent.velocity.x > 0:
		if parent_vector.x > parent_vector.y:
			target_position = Vector2(_raycast_range, 0)
	if parent.velocity.y < 0:
		if parent_vector.y > parent_vector.x:
			target_position = Vector2(0, -_raycast_range)
	if(parent.velocity.y > 0):
		if parent_vector.y > parent_vector.x:
			target_position = Vector2(0, _raycast_range)


