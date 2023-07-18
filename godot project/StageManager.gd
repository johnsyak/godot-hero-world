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

func set_player_position(scene, player_position):
	var stage = scene.instantiate()
	get_tree().get_root().get_child(1).free()
	get_tree().get_root().add_child(stage)
	
	var player = stage.get_tree().get_nodes_in_group("player_group")[0]
	player.set_global_position(player_position)


	

