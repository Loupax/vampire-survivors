class_name PlayerCharacter
extends Character

@export var speed: float 
signal level_up(who: PlayerCharacter)
@export var xp: int = 4
var xp_till_next_level: int = 0
var level: int = 1

func _ready() -> void:
	xp_till_next_level = get_required_xp(2)

func _process(delta: float) -> void:
	super._process(delta)
	var v: Vector2 = Vector2(0,0)	
	if Input.is_action_pressed("up"):
		v.y = -speed
	if Input.is_action_pressed("down"):
		v.y = speed
	if Input.is_action_pressed("left"):
		v.x = -speed
	if Input.is_action_pressed("right"):
		v.x = speed
	velocity = v
	$Health.scale.x = float(health)/float(maxHealth)

func get_required_xp(lvl):
	assert(lvl > 1, "Level must be over one")
	if lvl == 2:
		return 5
	elif lvl >= 2 and lvl <= 20:
		return 5 + 10 * (lvl - 1)
	elif lvl >= 21 and lvl <= 40:
		return 195 + 13 * (lvl - 20)
	elif lvl >= 41:
		return 455 + 16 * (lvl - 40)
	else:
		return 0  # Handle invalid levels if necessary
		
func _on_loot_attractor_area_entered(area: Area2D) -> void:
	var loot:XPCollectible = area as XPCollectible
	loot.player = self


func _on_loot_collector_area_entered(area: Area2D) -> void:
	var loot:XPCollectible = area as XPCollectible
	xp += loot.xp
	
	while xp >= xp_till_next_level:
		level += 1
		xp_till_next_level = get_required_xp(level+1)
		emit_signal("level_up", self)
		
	loot.queue_free()
