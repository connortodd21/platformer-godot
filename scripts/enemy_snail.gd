extends Area2D

@onready var snail_sprite = $AnimatedSprite2D

const SPEED = 100
var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta


func turn_around() -> void:
	direction *= -1
	snail_sprite.flip_h = !snail_sprite.flip_h

func _on_body_entered(body: Node2D) -> void:
	pass
