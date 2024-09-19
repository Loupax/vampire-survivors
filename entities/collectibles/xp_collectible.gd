class_name XPCollectible
extends Loot

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@export var speed:int
var player:Character
@export var xp:int

func _ready() -> void:
	animation.frame = 2

func _process(delta: float) -> void:
	if player != null:
		if position.x > player.position.x:
			position.x -= speed
		else: if position.x < player.position.x:
			position.x += speed
			
		if position.y > player.position.y:
			position.y -= speed
		else: if position.y < player.position.y:
			position.y += speed
