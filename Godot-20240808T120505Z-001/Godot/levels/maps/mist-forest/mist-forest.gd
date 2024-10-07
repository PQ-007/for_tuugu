extends Node2D

@onready var spawn_point_enemy = get_node("SpawnPointForEnemy").get_children()
var skeleton_warrior_scene = preload("res://Entities/Enemies/skeleton_warrior/skeleton_warrior.tscn")
var enemy_num = 0
func _ready():
	
	##Player spawn
	#if level_custom_data.mode == "singleplayer":
	var player_spawn_point := $SpawnPointForPlayer/SinglePlayer
	$SamuraiArcher.position = player_spawn_point.position
	for i in range(3):
		spawner()
		await get_tree().create_timer(5)
		
	
func _process(delta):
	pass
		
		

func begin_wave():
	pass

func spawner():
	enemy_num+=1
	var skeleton_warrior = skeleton_warrior_scene.instantiate()
	skeleton_warrior.position = spawn_point_enemy[randi() % 2].position
	add_child(skeleton_warrior)
	
