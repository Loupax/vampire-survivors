class_name Hurtbox
extends Area2D

@export var attacker:Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damage() -> int:
	return randi_range(1, 4)+2
	
func _on_area_entered(area: Area2D) -> void:
	area.get_parent().resolve_attack(attacker, area.get_parent(), damage())
	pass # Replace with function body.
