extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5
@export var tetherMax = 2*16

@onready var animations = $AnimatedSprite2D
@onready var lizardRaycast = $LizardRaycast

var tetherPos
var startPos
var endPos

var rng = RandomNumberGenerator.new()

func _ready():
	tetherPos = position
	startPos = tetherPos
	endPos = startPos + Vector2(0, 3*16)
	rng.randomize()
	var randPosX = rng.randi_range(-2, 2)
	var randPosY = rng.randi_range(-2, 2)

	endPos = startPos - Vector2(randPosX*16, randPosY*16)

func updateVelocity():
	var moveDirection = endPos - position

	if moveDirection.length() < limit:
		position = endPos
		changeDirection()
	
	velocity = moveDirection.normalized()*speed
	
func changeDirection():
	var tempEnd = endPos
	var posDif
	var tether = Vector2((tetherPos.x + tetherMax), (tetherPos.y + tetherMax))
	#endPos = startPos
	if(startPos.x > 0 and startPos.x > tether.x):
		resetPos()
	elif(startPos.y > 0 and startPos.y > tether.y):
		resetPos()
	elif(startPos.x < 0 and startPos.x < (tetherPos.x + -abs(tether.x))):
		resetPos()
	elif(startPos.y < 0 and startPos.y < (tetherPos.y + -abs(tether.y))):
		resetPos()
	else:
		startPos = tempEnd - Vector2((rng.randi_range(-2, 2))*16, (rng.randi_range(-2, 2))*16)
	endPos = startPos

func updateAnimation():
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
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		changeDirection()
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	handleCollision()
	updateAnimation()

	
func resetPos():
	startPos = tetherPos
	

	
	
