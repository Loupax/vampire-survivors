class_name Character
extends CharacterBody2D

signal health_depleted(who: Character)
signal damage_inflicted(who: Character, damage: int)

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var maxHealth: int
@export var health: float


var atk_multiplier:float = 1
var damage_reduction:float = 0
var flip_h:bool = false


func _process(_delta: float) -> void:
	if velocity.x > 0:
		animation.flip_h = true
		flip_h = true
	if velocity.x < 0:
		animation.flip_h = false
		flip_h = false 
		
	if velocity != Vector2(0,0):
		animation.play("walk")
	else:
		animation.play("idle")
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func add_child_scene(i: LevelUpOption):
	var child = i.child_scene.instantiate()
	if child.has_method("set_attacker"):
		child.set_attacker(self)
	add_child(child)
		
func resolve_attack(attacker: Character, receiver: Character, dmg: int):
	var dmg_dealt = int(round(dmg * attacker.atk_multiplier))
	var dmg_taken = dmg_dealt - receiver.damage_reduction
	if dmg_taken < 0:
		dmg_taken = 0
	
	receiver.health = receiver.health - (dmg_taken)
	damage_inflicted.emit(receiver, dmg_taken)
	if receiver.health < 0:
		health_depleted.emit(receiver)
