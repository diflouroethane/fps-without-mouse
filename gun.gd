extends Node3D

class_name Gun


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play(anim, _1, _2) -> void:
	$Gun2.play(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
