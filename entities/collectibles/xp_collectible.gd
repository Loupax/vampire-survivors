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
		position = position.move_toward(player.position, speed*delta)
