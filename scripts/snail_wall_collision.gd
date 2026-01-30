extends Node2D

var enemies: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_nodes = $"..".get_node_or_null("Enemies")
	if enemy_nodes:
		for enemy in enemy_nodes.get_children():
			enemies.append(enemy.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_center_pillar_area_entered(area: Area2D) -> void:
	if area.name in enemies:
		area.turn_around()


func _on_level_1_right_wall_area_entered(area: Area2D) -> void:
	if area.name in enemies:
		area.turn_around()


func _on_level_1_left_wall_area_entered(area: Area2D) -> void:
	if area.name in enemies:
		area.turn_around()
