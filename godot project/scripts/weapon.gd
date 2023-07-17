extends Node2D

var attack_damage := 10.0
var knockback_force := 100.00

func _on_hitbox_body_entered(area):
	if area is hitbox_component:
		var hitbox : hitbox_component = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		
		hitbox.damage(attack)
		
		
