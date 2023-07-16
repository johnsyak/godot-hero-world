extends Node2D

var DirectionUtil = preload("res://overlap/DirectionUtil.gd")


func changeDirection(endPosition: Vector2, startPosition: Vector2):
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity(position: Vector2, endPosition: Vector2, startPosition: Vector2, velocity: Vector2, limit: int, speed: int):
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection(endPosition, startPosition)
	velocity = moveDirection.normalized()*speed
	
func updateAnimation(velocity: Vector2, animations: AnimatedSprite2D):
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		animations.play(DirectionUtil.get_walk_direction(velocity.x, velocity.y))
