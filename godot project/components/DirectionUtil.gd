extends Node

const WALK_RIGHT = "walk_right"
const WALK_LEFT = "walk_left"
const WALK_DOWN = "walk_down"
const WALK_UP = "walk_up"

static func get_walk_direction(x, y):
	var animation_string = WALK_RIGHT
	var abs_velocity = Vector2(abs(x), abs(y))
	if y < 0:
		if abs_velocity.y > abs_velocity.x:
			animation_string = WALK_UP
	elif y > 0:
		if abs_velocity.y > abs_velocity.x:
			animation_string = WALK_DOWN
	if x < 0:
		if(abs_velocity.x > abs_velocity.y):
			animation_string = WALK_LEFT
	if x > 0:
		if abs_velocity.x > abs_velocity.y:
			animation_string = WALK_RIGHT
	return animation_string

static func get_fire_direction(x:float, y:float):
	var fire_direction
	match get_walk_direction(x, y):
		WALK_UP:
			fire_direction = Vector2(0, 1)
		WALK_DOWN:
			fire_direction = Vector2(0, -1)
		WALK_LEFT:
			fire_direction = Vector2(1, 0)
		WALK_RIGHT:
			fire_direction = Vector2(-1, 0)
	return fire_direction
	
static func get_attack_direction(x:float, y:float):
	return get_walk_direction(x, y)
