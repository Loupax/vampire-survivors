class_name Character
extends Node2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
var velocity: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity
	if velocity.x > 0:
		scale.x = 1
	if velocity.x < 0:
		scale.x = -1
		
	if velocity != Vector2(0,0):
		animation.play("walk")
	else:
		animation.play("idle")
			

func setVelocity(v: Vector2):
	velocity =  v
	
