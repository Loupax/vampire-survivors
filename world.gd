extends Node2D

@export var player: Character 
@onready var camera: Camera2D = $DefaultPC/Camera2D
@export var playerSpeed: float 
var enemy_scene: PackedScene = preload("res://entities/Enemy.tscn")
var damage_indicator_scene: PackedScene = preload("res://entities/Damage Indicator.tscn")
var game_over_scene: PackedScene = preload("res://Game Over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	
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


func _on_default_pc_health_depleted() -> void:
	player.hide()
	player.set_process(false)
	var game_over = game_over_scene.instantiate()
	game_over.position = player.position
	add_child(game_over)
	player.velocity = Vector2(0,0)


func _on_default_pc_damage_inflicted(who:Character, dmg:int) -> void:
	var damage_indicator: Label = damage_indicator_scene.instantiate()
	damage_indicator.text = "%s" % dmg 
	damage_indicator.position = who.position
	add_child(damage_indicator)
	
	
	fade_out_label(damage_indicator, 1)
	pass # Replace with function body.

func fade_out_label(label: Label, duration: float):
	var tween = get_tree().create_tween()
	# Animate the label's modulate property from its current value to fully transparent
	var c = label.modulate
	c.a = 0
	tween.tween_property(label, "modulate", c, duration)
	var cleanup = func():
		if is_queued_for_deletion():
			return
		label.queue_free()
		tween.kill()
	# Optionally, queue the tween for deletion after it's finished
	tween.tween_callback(cleanup)
	
