extends State

class_name Hit

@export var damageable : Damageable
@export var bot_state_machine : CharacterStateMachine
@export var dead_state : State
@export var return_state : State
func _ready():
	damageable.connect("on_hit", on_damageable_hit)




func on_damageable_hit(node : Node, damage_amount : int):
	
	if (itself.health > 0):
		emit_signal("interrupt_state", return_state)
	elif(itself.health == 0):
		emit_signal("interrupt_state", dead_state)
		next_state = dead_state
		
	


