extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpAvailable = true
@onready var coyoteTime = $CoyoteTime

func _physics_process(delta):
	#Gravity
	if is_on_floor():
		jumpAvailable = true 
		coyoteTime.start()
	if is_on_wall():
		jumpAvailable = true
		coyoteTime.start()
		velocity.y += gravity / 2 * delta
		print("On Wall")
	else:
		velocity.y += gravity * delta
		
	if coyoteTime.time_left == 0:
		jumpAvailable = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumpAvailable:
		velocity.y = JUMP_VELOCITY
		jumpAvailable = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
