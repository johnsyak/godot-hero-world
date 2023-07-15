extends CharacterBody2D

@export var speed = 30
@export var limit = 0.5
@export var tether_max = 2
@export var tile_move_dist = 3
@export var fire_rate = 0.4

@onready var animations = $AnimatedSprite2D
@onready var enemy_raycast = $EnemyRaycast
const projectile_path = preload("res://projectiles/projectile.tscn")
const DirectionUtil = preload("res://overlap/DirectionUtil.gd")

var tether_pos
var start_pos
var end_pos
var rng = RandomNumberGenerator.new()
var CONST_TILE_SIZE = 16

func _ready():
	tether_max = tether_max * CONST_TILE_SIZE 
	tether_pos = position
	start_pos = tether_pos
	end_pos = start_pos + Vector2(0, tile_move_dist * CONST_TILE_SIZE)
	rng.randomize()
	end_pos = start_pos - Vector2(_get_rand_range_threshold() * CONST_TILE_SIZE, _get_rand_range_threshold() * CONST_TILE_SIZE)

func _update_velocity():
	var moveDirection = end_pos - position
	if moveDirection.length() < limit:
		position = end_pos
		_change_direction()
	velocity = moveDirection.normalized()*speed
	
func _change_direction():
	var tempEnd = end_pos
	var tether = Vector2((tether_pos.x + tether_max), (tether_pos.y + tether_max))
	if(start_pos.x > 0 and start_pos.x > tether.x):
		_resetPos()
	elif(start_pos.y > 0 and start_pos.y > tether.y):
		_resetPos()
	elif(start_pos.x < 0 and start_pos.x < (tether_pos.x + -abs(tether.x))):
		_resetPos()
	elif(start_pos.y < 0 and start_pos.y < (tether_pos.y + -abs(tether.y))):
		_resetPos()
	else:
		start_pos = tempEnd - Vector2((_get_rand_range_threshold()) * CONST_TILE_SIZE, (_get_rand_range_threshold()) * CONST_TILE_SIZE)
	end_pos = start_pos

func _update_animation():
	animations.play(_get_direction())

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

func _resetPos() -> void:
	start_pos = tether_pos

func _get_rand_range_threshold():
	return rng.randi_range(-tile_move_dist, tile_move_dist)
	
func _get_direction():
	return DirectionUtil.get_walk_direction(velocity.x, velocity.y)

var timer = 0

func _process(delta):
	if(!enemy_raycast.is_colliding()):
		timer = 0
		return	
	if timer == 0:
		_on_enemy_raycast_fire()
	elif (timer>fire_rate):
		_on_enemy_raycast_fire()
		timer = 0
	timer+=delta

func _on_enemy_raycast_fire() -> void:
	var projectile = projectile_path.instantiate() 
	get_parent().add_child(projectile)
	projectile.position = $Marker2D.global_position
	projectile.velocity = DirectionUtil.get_fire_direction(velocity.x, velocity.y)


	

