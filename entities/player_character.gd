class_name PlayerCharacter
extends Character

@export var speed: float 

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
