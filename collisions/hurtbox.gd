class_name Hurtbox
extends Area2D

@export var damage: int = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	area.get_parent().get_attacked_by(self)
	pass # Replace with function body.
