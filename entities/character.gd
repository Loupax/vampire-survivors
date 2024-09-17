class_name Character
extends Node2D

signal health_depleted(who: Character)
signal damage_inflicted(who: Character, damage: int)
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@export var maxHealth: int
@export var health: int
var velocity: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position += velocity
	if velocity.x > 0:
		animation.scale.x = 1
	if velocity.x < 0:
		animation.scale.x = -1
		
	if velocity != Vector2(0,0):
		animation.play("walk")
	else:
		animation.play("idle")
	$Health.scale.x = float(health)/float(maxHealth)
		
func get_attacked_by(h: Hurtbox, dmg: int):
	health = health - dmg
	damage_inflicted.emit(self, dmg)
	if health < 0:
		health_depleted.emit(self)
