extends Node2D

@export var player: Node2D 
@export var playerSpeed: Vector2 = Vector2(10, 10)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player.position
	if Input.is_action_pressed("up"):
		player.position.y -= playerSpeed.y
	if Input.is_action_pressed("down"):
		player.position.y += playerSpeed.y
	if Input.is_action_pressed("left"):
		player.position.x -= playerSpeed.x
	if Input.is_action_pressed("right"):
		player.position.x += playerSpeed.x
	pass
