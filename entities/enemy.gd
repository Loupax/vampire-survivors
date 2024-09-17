class_name Enemy
extends Character

@export var playerCharacter: Character
@export var speed: float = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var v = Vector2(0,0)
	if playerCharacter.position.x > position.x:
		v.x = speed
	else:
		v.x = -speed
		
	if playerCharacter.position.y > position.y:
		v.y = speed
	else: 
		v.y = -speed
	velocity = v

func set_player_character(pc: Character):
	playerCharacter = pc
