extends Node
class_name Damageable
signal  on_hit(node: Node, damage_taken : int)
@export var itself : CharacterBody2D
@export var health_bar : ProgressBar



func hit(damage : int):
	itself.health -= damage
	itself.on_health_changed()
	print("damaged by 10")
	emit_signal("on_hit", get_parent(),damage)

		




