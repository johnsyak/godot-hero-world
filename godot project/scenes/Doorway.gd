extends Area2D

var door_entered = false


func _on_body_entered(body: CharacterBody2D):
	door_entered = true
	get_tree().change_scene_to_file("res://scenes/building.tscn")

func _on_body_exited(body: CharacterBody2D):
	door_entered = false
