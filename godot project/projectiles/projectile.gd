extends Area2D

@export var speed = 200
@export var velocity: Vector2
var screen_size
var start_position = position

func _ready():
	self.monitoring = true
	start_position = position
	screen_size = get_viewport_rect().size

func _process(delta):
	#var tmp_position = position
	#position = tmp_position - velocity * speed
	#if (position.x > start_position.x + screen_size.x) or (position.y > start_position.y + 500):
		#self.queue_free()
	position += transform.x * speed * delta
	if (position.x > start_position.x + screen_size.x) or (position.y > start_position.y + 500):
		self.queue_free()


