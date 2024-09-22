extends Node2D

@export var player: Character 
@onready var xp_indicator: Label = $"../CanvasLayer/UI/VBoxContainer/Label"
@onready var ui_scene = $"../CanvasLayer/UI"
var enemy_scene: PackedScene = preload("res://entities/goblin/goblin.tscn")
var damage_indicator_scene: PackedScene = preload("res://ui/Damage Indicator.tscn")
var level_up_scene: PackedScene = preload("res://ui/level_up_screen.tscn")
var game_over_scene: PackedScene = preload("res://Game Over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.xp = 4
	spawn_enemies_in_circle(player.position, 10, 250)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	xp_indicator.text = "LVL:%d XP: %d/%d" % [player.level, player.xp, player.xp_till_next_level]
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()


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
		enemy.set_player_character(player)
		enemy.connect("damage_inflicted", _on_default_pc_damage_inflicted)
		enemy.connect("health_depleted", _on_enemy_health_depleted)  # Create the enemy instance
		enemy.position = enemy_position     # Set the enemy's position
		add_child(enemy)                   # Add the enemy to the scene

func _on_enemy_health_depleted(who: Character) -> void:
	var enemy = who as Enemy
	who.queue_free()
	var loot = enemy.drop_loot()
	if loot != null:
		loot.position = who.position
		add_child(loot)
	
	

func _on_default_pc_health_depleted(who: Character) -> void:
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

func fade_out_label(label: Label, duration: float):
	var tween = get_tree().create_tween()
	var c = label.modulate
	c.a = 0
	tween.tween_property(label, "modulate", c, duration)
	var cleanup = func():
		if is_queued_for_deletion():
			return
		label.queue_free()
		tween.kill()
	tween.tween_callback(cleanup)
	
func _pause():
	process_mode = PROCESS_MODE_DISABLED
	
func _unpause():
	process_mode = PROCESS_MODE_INHERIT
	
func _on_default_pc_level_up(who: PlayerCharacter) -> void:
	call_deferred("_pause")
	
	var level_up = level_up_scene.instantiate()
	ui_scene.add_child(level_up)
	level_up.connect("level_up_option_selected",  _on_level_up_option_selected)

func _on_level_up_option_selected(what:LevelUpOption, ui:CanvasLayer):
	call_deferred("_unpause")
	
	what.level_up(player)
	ui.queue_free()
