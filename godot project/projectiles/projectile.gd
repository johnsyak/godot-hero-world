extends Area2D

@export var speed = 5
@export var velocity = Vector2()
var screen_size
var start_position = position
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tmp_position = position
	position = tmp_position - velocity * speed
	if (position.x > start_position.x + 500) or (position.y > start_position.y + 500):
		self.queue_free()
