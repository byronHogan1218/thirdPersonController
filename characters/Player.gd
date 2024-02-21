extends CharacterBody3D

const SPEED: float = 10.0
const JUMP_FORCE: float = 8.0
const GRAVITY: float = -18.0

var is_grounded: bool = false

func _ready():
	velocity = Vector3.ZERO

func _physics_process(delta):
	# Input handling
	var direction := Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z += 1
	if Input.is_action_pressed("move_backward"):
		direction.z -= 1
	if Input.is_action_just_pressed("jump") and is_grounded:
		velocity.y = JUMP_FORCE

	# Apply movement
	direction = direction.normalized()
	#direction = Camera3D.current.global_transform.basis.x * direction.x + Camera3D.current.global_transform.basis.z * direction.z
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	# Gravity
	velocity.y += GRAVITY * delta

	# Ground check
	is_grounded = is_on_floor()

	# Move the character
	move_and_slide()

# Additional functions for animations, camera control, etc.
