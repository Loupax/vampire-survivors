class_name HealthBar
extends ColorRect

@onready var health = $Health
var percentage: float = 1.0

func _process(_delta: float) -> void:
	health.get_rect().x = (percentage * health.get_rect().x)
