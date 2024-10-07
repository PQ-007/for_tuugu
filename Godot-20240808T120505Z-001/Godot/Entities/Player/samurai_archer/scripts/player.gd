extends CharacterBody2D
class_name Player

@export var health := 100
@export var speed := 200
@export var damage := 10
@onready var health_bar := get_parent().get_node("HUD/PlayerHealthBar")
@onready var projectiles := get_parent().get_node("Projectiles")
@onready var sprite :Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var arrow_scene = preload("res://Entities/Player/arrow.tscn")

signal facing_direction_changed(facing_right : bool)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := Vector2.ZERO
func _ready():
	animation_tree.active = true
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
			
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Control whether to move or not to move
	if direction.x != 0 and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameter()
	update_facing_direction()
	
func update_animation_parameter():
	animation_tree.set("parameters/move/blend_position", direction.x)
	

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
func on_health_changed():
	health_bar.value = health
	
func shoot():
	var arrow = arrow_scene.instantiate()
	if direction.x > 0:
		arrow.position = Vector2(position.x + 30, position.y + 10)
		arrow.direction = Vector2.RIGHT
	elif direction.x < 0:
		arrow.position = Vector2(position.x - 30, position.y + 10)
		arrow.direction = Vector2.LEFT
	projectiles.add_child(arrow)



