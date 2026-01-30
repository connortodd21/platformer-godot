extends Node2D

@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _setup_level() -> void:
	# connect enemies
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_hit_snail.connect(_on_player_hit)
			
	# connect apples
	var collectibles = $LevelRoot.get_node_or_null("Collectibles")
	if collectibles:
		for collectible in collectibles.get_children():
			collectible.collected.connect(_on_collectible_collected)
			
func _on_collectible_collected() -> void:
	score += 1
	score_label.text = "SCORE: %d" % score

func _on_player_hit(body: Node2D) -> void:
	body.handle_snail_collision()
