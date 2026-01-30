extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _setup_level() -> void:
	# connect enemies
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_hit_snail.connect(_on_player_hit)
		

func _on_player_hit(body: Node2D) -> void:
	body.handle_snail_collision()
