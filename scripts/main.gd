extends Node2D

@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel
@onready var current_level_root: Node = null
@onready var fade: ColorRect = $HUD/Fade


var score: int = 0
var level : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.modulate.a = 1.0
	current_level_root = get_node("LevelRoot")
	await load_level(level, false)


func load_level(level_to_load: int, should_reset_score: bool) -> void:
	await _fade(1.0)
	if should_reset_score:
		update_score(0)
	# remove old level
	if current_level_root:
		current_level_root.queue_free()
	
	var level_path = "res://scenes/levels/level%d.tscn" % level_to_load
	current_level_root = load(level_path).instantiate()
	call_deferred("add_child", current_level_root)
	current_level_root.name = "LevelRoot"
	_setup_level(current_level_root)
	
	await _fade(0)


func _setup_level(level_root: Node) -> void:
	# connect enemies
	var enemies = level_root.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_hit_snail.connect(_on_player_hit)
	
	# connect apples
	var collectibles = level_root.get_node_or_null("Collectibles")
	if collectibles:
		for collectible in collectibles.get_children():
			collectible.collected.connect(_on_collectible_collected)
	
	# connect exit
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit)


func _on_exit(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false
		await load_level(level, false)
	
	
func _on_collectible_collected() -> void:
	update_score(score + 1)

func update_score(new_score: int) -> void:
	score = new_score
	score_label.text = "SCORE: %d" % score

func _on_player_hit(body: Node2D) -> void:
	level = 1
	body.handle_snail_collision()
	await load_level(level, true)
	
func _fade(to_alpha: float) -> void:
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", to_alpha, 1.5)
	await tween.finished
