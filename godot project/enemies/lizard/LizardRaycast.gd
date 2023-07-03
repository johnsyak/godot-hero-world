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
	var velocityX = abs(parent.velocity.x)
	var velocityY = abs(parent.velocity.y)
	var vx = parent.velocity.x
	var vy = parent.velocity.y
	if parent.velocity.x < 0:
		if velocityX > velocityY:
			_set_target_positions(0, -_raycast_range)
	if parent.velocity.x > 0:
		if velocityX > velocityY:
			_set_target_positions(0, _raycast_range)
	if parent.velocity.y < 0:
		if velocityY > velocityX:
			_set_target_positions(-_raycast_range, 0)
	if(parent.velocity.y > 0):
		if velocityY > velocityX:
			_set_target_positions(_raycast_range, 0)
			
func _set_target_positions(value1, value2):
	target_position.y = value1
	target_position.x = value2
