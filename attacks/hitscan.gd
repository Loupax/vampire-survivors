class_name HitscanAttack
extends Node2D
@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var ray:ShapeCast2D = $ShapeCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the sprite initially
	animation.hide()

	# Connect the frame_changed signal to detect when animation frame changes
	animation.connect("frame_changed", _on_frame_changed)

func _on_frame_changed():
	if animation.frame == animation.sprite_frames.get_frame_count("default") - 1:
		# Stop the animation and hide the sprite when it reaches the last frame
		animation.stop()
		animation.hide()

func _on_timer_timeout() -> void:
	animation.show()
	animation.play("default")
	hit_enemies()

func hit_enemies():
	var colls = []
	ray.force_shapecast_update()  
	
	while ray.is_colliding():
		for i in range(ray.get_collision_count()):
			var obj = ray.get_collider(i)
			colls.append(obj)
			obj.get_parent().get_attacked_by(null, randi_range(1, 4) + 1)

		for o in colls:
			ray.add_exception(o)
			
		ray.force_shapecast_update()  
		
	for o in colls:
		ray.remove_exception(o)
