extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimationPlayer

const DirectionUtil = preload("res://components/DirectionUtil.gd")

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		animations.play(DirectionUtil.get_walk_direction(velocity.x, velocity.y))
		
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
	

	
