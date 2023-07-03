extends CharacterBody2D

@export var speed = 0
@export var limit = 0.5
@export var tether_max = 2
@export var tile_move_dist = 3
@export var fire_rate = 1

@onready var animations = $AnimatedSprite2D
@onready var enemy_raycast = $EnemyRaycast

var _tether_pos
var _start_pos
var _end_pos
var _rng = RandomNumberGenerator.new()
var _CONST_TILE_SIZE = 16

func _ready():
	tether_max = tether_max * _CONST_TILE_SIZE 
	_tether_pos = position
	_start_pos = _tether_pos
	_end_pos = _start_pos + Vector2(0, tile_move_dist * _CONST_TILE_SIZE)
	_rng.randomize()
	_end_pos = _start_pos - Vector2(_get_rand_range_threshold() * _CONST_TILE_SIZE, _get_rand_range_threshold() * _CONST_TILE_SIZE)

func _update_velocity():
	var moveDirection = _end_pos - position
	if moveDirection.length() < limit:
		position = _end_pos
		_change_direction()
	velocity = moveDirection.normalized()*speed
	
func _change_direction():
	var tempEnd = _end_pos
	var tether = Vector2((_tether_pos.x + tether_max), (_tether_pos.y + tether_max))
	if(_start_pos.x > 0 and _start_pos.x > tether.x):
		_resetPos()
	elif(_start_pos.y > 0 and _start_pos.y > tether.y):
		_resetPos()
	elif(_start_pos.x < 0 and _start_pos.x < (_tether_pos.x + -abs(tether.x))):
		_resetPos()
	elif(_start_pos.y < 0 and _start_pos.y < (_tether_pos.y + -abs(tether.y))):
		_resetPos()
	else:
		_start_pos = tempEnd - Vector2((_get_rand_range_threshold()) * _CONST_TILE_SIZE, (_get_rand_range_threshold()) * _CONST_TILE_SIZE)
	_end_pos = _start_pos

func update_animation():
	var animationString = "walk_up"
	var velocityX = abs(velocity.x)
	var velocityY = abs(velocity.y)
	if velocity.y < 0:
		if velocityY > velocityX:
			animationString = "walk_up"
	if velocity.y > 0:
		if velocityY > velocityX:
			animationString = "walk_down"
	if velocity.x < 0:
		if(velocityX > velocityY):
			animationString = "walk_left"
	if velocity.x > 0:
		if velocityX > velocityY:
			animationString = "walk_right"
	animations.play(animationString)
	
func _handle_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		_change_direction()
	
func _physics_process(delta):
	_update_velocity()
	move_and_slide()
	_handle_collision()
	update_animation()

func _resetPos():
	_start_pos = _tether_pos

func _on_enemy_raycast_fire():
	print("LIZURD FIRE")
	
func _get_rand_range_threshold():
	return _rng.randi_range(-tile_move_dist, tile_move_dist)

var _timer = 0

func _process(delta):
	if(enemy_raycast.is_colliding()):
		if _timer == 0:
			_on_enemy_raycast_fire()
		elif (_timer>fire_rate):
			_on_enemy_raycast_fire()
			_timer = 0
		_timer+=delta
#	else:
#		_timer = 0




