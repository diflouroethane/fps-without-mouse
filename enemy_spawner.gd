extends Node3D

@export var box: PackedScene
var speed: float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_spawn_timer_timeout() -> void:
	get_parent().progress_ratio = randf()
	var a: Monster = box.instantiate()
	get_parent().get_parent().add_child(a)
	a.global_rotation = global_rotation
	a.global_position = global_position
	print("spwaner added child")
	#pass
