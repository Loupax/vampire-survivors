class_name PlayerCharacter
extends Character

@export var speed: float 
var xp: int = 0

func _process(delta: float) -> void:
	super._process(delta)
	var v: Vector2 = Vector2(0,0)	
	if Input.is_action_pressed("up"):
		v.y = -speed
	if Input.is_action_pressed("down"):
		v.y = speed
	if Input.is_action_pressed("left"):
		v.x = -speed
	if Input.is_action_pressed("right"):
		v.x = speed
	velocity = v
	$Health.scale.x = float(health)/float(maxHealth)


func _on_loot_attractor_area_entered(area: Area2D) -> void:
	var loot:XPCollectible = area as XPCollectible
	loot.player = self


func _on_loot_collector_area_entered(area: Area2D) -> void:
	var loot:XPCollectible = area as XPCollectible
	xp += loot.xp
	loot.queue_free()
