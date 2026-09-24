extends Node3D

class_name Spawner

var enemies: int
var enemies_spawned: int = 0
@export var interval: float = 0.5

@export var box: PackedScene
var speed: float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.wait_time = interval
	print("wait_time: ", $SpawnTimer.wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemies_spawned >= enemies:
		$SpawnTimer.stop()
		$SpawnTimer.autostart = false



func _on_spawn_timer_timeout() -> void:
	print(Time.get_datetime_string_from_system())
	get_parent().progress_ratio = randf()
	var a: Monster = box.instantiate()
	get_parent().get_parent().add_child(a)
	a.global_rotation = global_rotation
	a.global_position = global_position
	print("spwaner added child")
	enemies_spawned+=1
	#pass
