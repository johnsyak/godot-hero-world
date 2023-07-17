extends Area2D
class_name hitbox_component

@export var health_component: health_component

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
