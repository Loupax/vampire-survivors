class_name Enemy
extends Character

@export var playerCharacter: Character
@export var speed: float = 10
var xp_pickup_scene: PackedScene = preload("res://entities/collectibles/xp_collectible.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var v = Vector2(0, 0)

	# Calculate direction vector towards player
	v.x = playerCharacter.position.x - position.x
	v.y = playerCharacter.position.y - position.y

	# Normalize the vector to ensure diagonal movement is not faster
	v = v.normalized() * speed

	# Apply delta to make movement frame-rate independent
	velocity = v * delta

	# Update position
	position += velocity

func set_player_character(pc: Character):
	playerCharacter = pc

func drop_loot() -> Loot:
	if randi_range(0,3) == 0:
		return xp_pickup_scene.instantiate()
	return null
