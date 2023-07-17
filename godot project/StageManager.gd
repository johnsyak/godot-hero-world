extends CanvasLayer

const WORLD = preload("res://scenes/world.tscn")
const BUILDING = preload("res://scenes/building.tscn")

func _ready():
	hide_elements()

func change_stage(stage_path, spawn_position: Vector2):
	show_elements()
	get_node("FadeAnim").play("fade_in")
	await get_node("FadeAnim").animation_finished
	set_player_position(stage_path, spawn_position)
	hide_elements()

	
func hide_elements():
	get_node("ColorRect").hide()
	get_node("Label").hide()

func show_elements():
	get_node("ColorRect").show()
	get_node("Label").show()

func set_player_position(stage_path, player_position):
	var stage = stage_path.instantiate()
	var player = get_tree().get_nodes_in_group("player_group")[0]
	player.free()
	get_tree().get_root().add_child(stage)
#	var player2 = stage.get_node("Player")

	#stage.get_tree().get_nodes_in_group("player_group")[0].position = player_position
