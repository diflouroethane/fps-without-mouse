extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var rotate_speed: float = 0.5
var rotate_step: int = 45
var target_rotation: float

func _ready() -> void:
	target_rotation = global_rotation.y

func _physics_process(delta: float) -> void:
	#print("hii")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("rotate_left"):
		rotate_player(1)
	elif Input.is_action_just_pressed("rotate_right"):
		rotate_player(-1)
		
	if Input.is_action_just_pressed("shoot"):
		$Gun2.play("shoot")
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	global_rotation.y = lerp_angle(global_rotation.y, deg_to_rad(target_rotation), rotate_speed)
	#if global_rotation.y != target_rotation:
		#if global_rotation.y > target_rotation+threshold:
			#
	move_and_slide()

func rotate_player(dir: int, step: int = rotate_step) -> void:
	print("hi", target_rotation, global_rotation.y)
	#target_rotation = deg_to_rad((global_rotation.y+90)*dir) #in degrees
	target_rotation += (step*dir)
	target_rotation = snappedf(target_rotation, step)
	#rotate_y(target_rotation)
	
