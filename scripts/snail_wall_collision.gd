extends Node2D

@onready var snails := ["EnemySnail", "EnemySnail2"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_center_pillar_area_entered(area: Area2D) -> void:
	if area.name in snails:
		area.turn_around()


func _on_level_1_right_wall_area_entered(area: Area2D) -> void:
	if area.name in snails:
		area.turn_around()


func _on_level_1_left_wall_area_entered(area: Area2D) -> void:
	if area.name in snails:
		area.turn_around()
