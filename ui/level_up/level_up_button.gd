extends Button

@export var level_up_option:LevelUpOption
signal level_up_option_selected(o:LevelUpOption)
func _ready() -> void:
	text = level_up_option.name


func _on_pressed() -> void:
	emit_signal("level_up_option_selected", level_up_option)
