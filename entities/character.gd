class_name Character
extends CharacterBody2D

signal health_depleted(who: Character)
signal damage_inflicted(who: Character, damage: int)

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var maxHealth: int
@export var health: int

func _process(_delta: float) -> void:
	if velocity.x > 0:
		animation.scale.x = -1
	if velocity.x < 0:
		animation.scale.x = 1
		
	if velocity != Vector2(0,0):
		animation.play("walk")
	else:
		animation.play("idle")
	
func _physics_process(delta: float) -> void:
	move_and_slide()
		
func get_attacked_by(h: Hurtbox, dmg: int):
	health = health - dmg
	damage_inflicted.emit(self, dmg)
	if health < 0:
		health_depleted.emit(self)
