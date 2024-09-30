extends Node2D
var spawnpoints
@export var PlayerScene : PackedScene
var arrow_scene = preload("res://Entities/Player/arrow.tscn")
var skeleton_scene = preload("res://Entities/Enemies/skeleton_warrior.tscn")
var character
func _ready(): 
	#for i in range(3):
		#var skeleton = skeleton_scene.instantiate()
		#skeleton.position = Vector2(i*100, character.position.y)
		#add_child(skeleton)
	spawnpoints = $SpawnPointForPlayer.get_children()
	var index = 0
	var keys = NakamaMultiplayer.Players.keys()
	keys.sort()
	for i in keys:
		
		var instancePlayer = PlayerScene.instantiate()
		instancePlayer.name = str(NakamaMultiplayer.Players[i].name)
		if NakamaMultiplayer.Players[i].name == Global.local_player_id:
			character = instancePlayer
		print(instancePlayer.name)
		add_child(instancePlayer)
		
		instancePlayer.global_position = spawnpoints[index].global_position
		index += 1
	
func _process(_delta):
	if Global.shooting:
		Global.shooting = false
		var arrow = arrow_scene.instantiate()
		if character.direction.x > 0:
			arrow.position = Vector2(character.position.x + 30, character.position.y + 10)
			arrow.direction = Vector2.RIGHT
		elif character.direction.x < 0:
			arrow.position = Vector2(character.position.x - 30, character.position.y + 10)
			arrow.direction = Vector2.LEFT
		$Projectiles.add_child(arrow)
	Global.player_pos = character.position
	
	
	



