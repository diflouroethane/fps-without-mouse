extends StaticBody3D

class_name Monster
@export var impact: PackedScene
var dead:bool = false
var spd: float = 3.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spd += Global.rooms_completed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(Global.player_pos)
	if !dead:
		position += (-basis.z) *spd*delta

func die() -> void:
	if !dead:
		Global.room["enemies"]-=1
		dead = true
	print(Global.room["enemies"])
	$MeshInstance3D.hide()
	var i: CPUParticles3D = impact.instantiate()
	add_child(i)
	i.emitting = true
	await get_tree().create_timer(0.5).timeout
	i.queue_free()
	queue_free()
