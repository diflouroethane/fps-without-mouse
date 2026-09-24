extends Camera3D

var decay = 0.8
var max_roll = deg_to_rad(30)
var trauma = 0.0
var trauma_power = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func add_t(amt) -> void:
	trauma = min(trauma+amt, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amt = pow(trauma, trauma_power)
	rotation.x = max_roll * amt * randf_range(-1, 1)
	rotation.y = max_roll * amt * randf_range(-1, 1)
