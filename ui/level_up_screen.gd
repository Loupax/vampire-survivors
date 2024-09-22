extends CanvasLayer

signal level_up_option_selected(o:LevelUpOption, ui:CanvasLayer)

func _on_level_up_option_selected(o: LevelUpOption) -> void:
	emit_signal("level_up_option_selected", o, self)
