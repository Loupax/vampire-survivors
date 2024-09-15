extends Node2D

@export var player: Character 
@onready var camera: Camera2D = $DefaultPC/Camera2D
@export var playerSpeed: float 
var enemy_scene: PackedScene = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	printerr(camera.get_viewport_rect().size.x)
	spawn_enemies_in_circle(player.position, 10, 250)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var v: Vector2 = Vector2(0,0)	
	if Input.is_action_pressed("up"):
		v.y = -playerSpeed
	if Input.is_action_pressed("down"):
		v.y = playerSpeed
	if Input.is_action_pressed("left"):
		v.x = -playerSpeed
	if Input.is_action_pressed("right"):
		v.x = playerSpeed
	
	player.velocity = v


func _on_timer_timeout() -> void:
	spawn_enemies_in_circle(player.position, 10, 250)
	

func spawn_enemies_in_circle(player_position: Vector2, num_enemies: int, radius: float):
	for i in range(num_enemies):
		var angle = (2 * PI / num_enemies) * i  # Calculate the angle for this enemy
		var enemy_position = Vector2(
			player_position.x + radius * cos(angle),
			player_position.y + radius * sin(angle)
		)
		
		var enemy = enemy_scene.instantiate()
		enemy.set_player_character(player)  # Create the enemy instance
		enemy.position = enemy_position     # Set the enemy's position
		add_child(enemy)                   # Add the enemy to the scene
