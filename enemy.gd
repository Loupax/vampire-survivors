class_name Enemy
extends Character

@export var playerCharacter: Character
@export var speed: float = 0.2
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2(0,0)
	if playerCharacter.position.x > position.x:
		velocity.x = speed
	else:
		velocity.x = -speed
		
	if playerCharacter.position.y > position.y:
		velocity.y = speed
	else: 
		velocity.y = -speed
	position += velocity

func set_player_character(pc: Character):
	playerCharacter = pc
