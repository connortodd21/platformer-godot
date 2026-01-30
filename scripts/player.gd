extends CharacterBody2D

@onready var animations := $Animations
@onready var jump_sound = $JumpSound
@onready var hit_sound = $HitSound

const SPEED = 300.0
const JUMP_VELOCITY = -850.0
var player_is_alive = true


func _physics_process(delta: float) -> void:
	if !player_is_alive:
		return
	# Add animation
	if velocity.x > 1 or velocity.x < -1:
		animations.animation = "run"
	else:
		animations.animation = "idle"
	
	# Add the gravity and use jumping animatino
	if not is_on_floor():
		velocity += get_gravity() * delta
		animations.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# ensure player faces correct direction
	if direction == 1:
		animations.flip_h = false
	elif direction == -1:
		animations.flip_h = true


func handle_snail_collision() -> void:
	hit_sound.play()
	player_is_alive = false
	animations.animation = "hit"
	
