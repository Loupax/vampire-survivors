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
	printerr(animation.frame)
	if animation.frame == animation.sprite_frames.get_frame_count("default") - 1:
		# Stop the animation and hide the sprite when it reaches the last frame
		animation.stop()
		animation.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	animation.show()
	animation.play("default")
	printerr("Collision check running", ray.is_colliding())
	hit_enemies()
	pass # Replace with function body.

func hit_enemies():
	var colls = []
	ray.force_shapecast_update()  # Ensure the ShapeCast2D is updated before checking collisions
	
	while ray.is_colliding():
		# Loop over the colliders
		for i in range(ray.get_collision_count()):
			var obj = ray.get_collider(i)
			if obj in colls:
				continue  # Skip already processed colliders
			colls.append(obj)
			printerr("Collider: ", obj, " Parent: ", obj.get_parent())
			
			obj.get_parent().get_attacked_by(null, randi_range(1, 4) + 1)

		# Add all processed colliders to the exception list
		for o in colls:
			ray.add_exception(o)
		
		ray.force_shapecast_update()  # Update the ShapeCast2D after adding exceptions

	# Clean up by removing all exceptions added earlier
	for o in colls:
		ray.remove_exception(o)
