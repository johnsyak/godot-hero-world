extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5
@export var tetherMax = 2*16
@export var tile_move_dist = 3

@onready var animations = $AnimatedSprite2D
@onready var enemy_raycast = $EnemyRaycast

var tetherPos
var startPos
var endPos
var rng = RandomNumberGenerator.new()
var CONST_TILE_SIZE = 16

func _ready():
	#EnemyRaycast._on_enemy_raycast_fire.connect(_on_enemy_raycast_fire)
	tetherPos = position
	startPos = tetherPos
	endPos = startPos + Vector2(0, tile_move_dist * CONST_TILE_SIZE)
	rng.randomize()
	endPos = startPos - Vector2(_get_rand_range_threshold() * CONST_TILE_SIZE, _get_rand_range_threshold() * CONST_TILE_SIZE)

func _update_velocity():
	var moveDirection = endPos - position

	if moveDirection.length() < limit:
		position = endPos
		_changeDirection()
	
	velocity = moveDirection.normalized()*speed
	
func _changeDirection():
	var tempEnd = endPos
	var tether = Vector2((tetherPos.x + tetherMax), (tetherPos.y + tetherMax))

	if(startPos.x > 0 and startPos.x > tether.x):
		_resetPos()
	elif(startPos.y > 0 and startPos.y > tether.y):
		_resetPos()
	elif(startPos.x < 0 and startPos.x < (tetherPos.x + -abs(tether.x))):
		_resetPos()
	elif(startPos.y < 0 and startPos.y < (tetherPos.y + -abs(tether.y))):
		_resetPos()
	else:
		startPos = tempEnd - Vector2((_get_rand_range_threshold()) * CONST_TILE_SIZE, (_get_rand_range_threshold()) * CONST_TILE_SIZE)
	endPos = startPos

func update_animation():
	var animationString = "walkUp"
	var velocityX = abs(velocity.x)
	var velocityY = abs(velocity.y)
	if velocity.y < 0:
		if velocityY > velocityX:
			animationString = "walkUp"
	if velocity.y > 0:
		if velocityY > velocityX:
			animationString = "walkDown"
	if velocity.x < 0:
		if(velocityX > velocityY):
			animationString = "walkLeft"
	if velocity.x > 0:
		if velocityX > velocityY:
			animationString = "walkRight"
	animations.play(animationString)
	
func _handle_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		_changeDirection()
	
func _physics_process(delta):
	_update_velocity()
	move_and_slide()
	_handle_collision()
	update_animation()

func _resetPos():
	startPos = tetherPos

func _on_enemy_raycast_fire():
	print("LIZURD FIRE")
	
func _get_rand_range_threshold():
	return rng.randi_range(-tile_move_dist, tile_move_dist)
	
func _process(delta):
	if(enemy_raycast.is_colliding()):
		_on_enemy_raycast_fire()
