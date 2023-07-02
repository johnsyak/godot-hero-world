extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var parent = get_parent()
	var velocityX = abs(parent.velocity.x)
	var velocityY = abs(parent.velocity.y)
	var vx = parent.velocity.x
	var vy = parent.velocity.y
	if parent.velocity.x < 0:
		if velocityX > velocityY:
			target_position.y = 0
			target_position.x = -50
	if parent.velocity.x > 0:
		if velocityX > velocityY:
			target_position.y = 0
			target_position.x = 50
	if parent.velocity.y < 0:
		if velocityY > velocityX:
			target_position.x = 0
			target_position.y = -50
	if(parent.velocity.y > 0):
		if velocityY > velocityX:
			target_position.x = 0
			target_position.y = 50
	#print(self.is_colliding)
