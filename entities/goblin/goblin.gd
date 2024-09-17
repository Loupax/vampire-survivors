class_name Goblin
extends Enemy
const FLIP_THRESHOLD = -5
func _process(delta: float) -> void:
	super._process(delta)
	animation.play("choppy_walk")
	if velocity.x > 0:
		animation.scale.x = -1
	if velocity.x < FLIP_THRESHOLD:
		animation.scale.x = 1
