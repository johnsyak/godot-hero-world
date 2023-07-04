extends CharacterBody2D

@export var speed = 30
@export var limit = 0.5
@export var tether_max = 2
@export var tile_move_dist = 3
@export var fire_rate = 0.4

@onready var animations = $AnimatedSprite2D
@onready var enemy_raycast = $EnemyRaycast
const projectilePath = preload("res://projectiles/projectile.tscn")

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

func _update_animation():
	var animationString = "walk_up"
	var normalized_velocity = Vector2(abs(velocity.x), abs(velocity.y))
	if velocity.y < 0:
		if normalized_velocity.y > normalized_velocity.x:
			animationString = "walk_up"
	elif velocity.y > 0:
		if normalized_velocity.y > normalized_velocity.x:
			animationString = "walk_down"
	if velocity.x < 0:
		if(normalized_velocity.x > normalized_velocity.y):
			animationString = "walk_left"
	if velocity.x > 0:
		if normalized_velocity.x > normalized_velocity.y:
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
	_update_animation()

func _resetPos():
	_start_pos = _tether_pos

func _get_rand_range_threshold():
	return _rng.randi_range(-tile_move_dist, tile_move_dist)

var _timer = 0

func _process(delta):
	if(!enemy_raycast.is_colliding()):
		return
	if _timer == 0:
		_on_enemy_raycast_fire()
	elif (_timer>fire_rate):
		_on_enemy_raycast_fire()
		_timer = 0
	_timer+=delta
#	else:
#		_timer = 0
func _on_enemy_raycast_fire() -> void:
	print("Lizurd fire!")
	var projectile = projectilePath.instantiate() 
	get_parent().add_child(projectile)
	projectile.position = $Marker2D.global_position
	projectile.velocity = Vector2(100,0)
#	var inst = projectile.instantiate()
#	owner.add_child(inst)
#	inst.transform = get_node("Marker2D").global_transform


