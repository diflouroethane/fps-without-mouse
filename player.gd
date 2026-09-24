extends CharacterBody3D

class_name Player

@export var bullet_scene: PackedScene

const SPEED = 10
const anim_speed: float = 2.0
const JUMP_VELOCITY = 4.5
var rotate_speed: float = 0.5
var rotate_speed2: float = 0.25
var rotate_step: int = 45
var target_rotation: float
var camera_to: float
var target_camera_rotation_left: float = 2.5
var target_camera_rotation_right: float = -2.5
var dashing: bool = false
var max_health: int = 10
var health: int = max_health
var def_s: float = 0.05
var s: float = def_s
@onready var progress_bar: ProgressBar = $CameraPivot/CanvasLayer/Control/VBoxContainer/ProgressBar

func _ready() -> void:
	progress_bar.max_value = max_health
	progress_bar.value = health
	$CameraPivot/hurtFlash.visible = false
	set_speeds(anim_speed)
	Global.player_pos = global_position
	target_rotation = global_rotation.y

func _physics_process(delta: float) -> void:
	$CameraPivot/CanvasLayer/Control/VBoxContainer/EnemiesLabel.text = "Enemies left: %d" % Global.room["enemies"]
	Global.player_pos = global_position
	#print("hii")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if Input.is_action_just_pressed("dash"):
		dashing = true
		
		#print("dash")
	
	if Input.is_action_just_pressed("rotate_left"):
		rotate_player(1)
	elif Input.is_action_just_pressed("rotate_right"):
		rotate_player(-1)
	
	if Input.is_action_just_pressed("left"):
		camera_to = target_camera_rotation_left
	if Input.is_action_just_pressed("right"):
		camera_to = target_camera_rotation_right
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		camera_to = 0
	
	if Input.is_action_just_pressed("shoot"):
		if $GunAnimationPlayer.is_playing() == false:
			$GunAnimationPlayer.play("shoot")
		#$CameraPivot/Gun2.play("shoot")
		#shoot()
	
	if direction:
		velocity.x = direction.x * SPEED * (15 if dashing else 1)
		velocity.z = direction.z * SPEED * (15 if dashing else 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	global_rotation.y = lerp_angle(global_rotation.y, deg_to_rad(target_rotation), rotate_speed)
	$CameraPivot.global_rotation.z = lerp_angle($CameraPivot.global_rotation.z, deg_to_rad(camera_to), rotate_speed2)
	#if global_rotation.y != target_rotation:
		#if global_rotation.y > target_rotation+threshold:
			#
	dashing = false
	
	move_and_slide()

func shoot() -> void:
	var b: Bullet  = bullet_scene.instantiate()
	
	get_parent().add_child(b)
	b.global_transform = $CameraPivot/Muzzle.global_transform
	b.scale = Vector3(s,s,s)

func rotate_player(dir: int, step: int = rotate_step) -> void:
	#print("hi", target_rotation, global_rotation.y)
	#target_rotation = deg_to_rad((global_rotation.y+90)*dir) #in degrees
	target_rotation += (step*dir)
	target_rotation = snappedf(target_rotation, step)
	#rotate_y(target_rotation)
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Monster:
		hurt()

func set_speeds(spd: float) -> void:
	$GunAnimationPlayer.speed_scale = spd
	$CameraPivot/Gun2.speed_scale = spd

func hurt() -> void:
	$GunAnimationPlayer.play("hurt")
	$CameraPivot/Camera3D.add_t(0.15)
	$CameraPivot/Camera3D.shake()
	progress_bar.value = health
	health -= 1
	if health <= 0:
		print("dead")
		get_tree().quit()

func pUp(type: Global.powerups) -> void:
	print("got a powerup of ", Global.powerups.keys()[type], "!!!")
	if type == Global.powerups.FASTSHOOT:
		$PowerupTimer.wait_time = 2
		set_speeds(200)
		$PowerupTimer.timeout.connect(fastshoot_end)
		
	elif type == Global.powerups.LARGEBULLETS:
		$PowerupTimer.wait_time = 5
		s = 50
		$PowerupTimer.timeout.connect(largebullets_end)
	elif type == Global.powerups.SPEED:
		pass
	$PowerupTimer.start()
	
func fastshoot_end() -> void:
	print("hi")
	set_speeds(anim_speed)

func largebullets_end() -> void:
	s = def_s
	print("large bullets ended")
