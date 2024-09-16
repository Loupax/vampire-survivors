class_name HitscanAttack
extends Node2D
@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var ray:RayCast2D = $RayCast2D
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
	if ray.is_colliding():
		printerr("Colliding ", get_hit_areas())
	pass # Replace with function body.

func get_hit_areas() -> Array[Enemy]:
	#ray is your RayCast2D node.
	var objects_collide:Array[Area2D] = [] #The colliding objects go here.
	var enemies:Array[Enemy]
	while ray.is_colliding():
		var obj = ray.get_collider() #get the next object that is colliding.
		objects_collide.append( obj ) #add it to the array.
		ray.add_exception( obj ) #add to ray's exception. That way it could detect something being behind it.
		ray.force_raycast_update() #update the ray's collision query.

	for obj in objects_collide:
		ray.remove_exception( obj )
		enemies.append(obj.get_parent())
	return enemies
