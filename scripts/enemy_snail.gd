extends Area2D

signal player_hit_snail

@onready var animations := $Animations
@onready var snail_hit_timer := $SnailHitTimer

const SPEED = 100
var direction = -1
var old_direction = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta


func handle_player_collision() -> void:
	animations.animation = "hit"
	old_direction = direction
	direction = 0
	snail_hit_timer.start()

func turn_around() -> void:
	direction *= -1
	animations.flip_h = !animations.flip_h

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.player_is_alive:
		player_hit_snail.emit(body)
		handle_player_collision()


func _on_snail_hit_timer_timeout() -> void:
	animations.animation = "idle"
	direction = old_direction
	snail_hit_timer.stop()
