extends StaticBody3D

class_name Monster
@export var impact: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += basis.x *1*delta

func die() -> void:
	$MeshInstance3D.hide()
	var i: CPUParticles3D = impact.instantiate()
	add_child(i)
	i.emitting = true
	await get_tree().create_timer(0.5).timeout
	i.queue_free()
	queue_free()
