extends Node3D

@onready var animation_player: AnimationPlayer = $"../../../AnimationPlayer"
@onready var player: Player = $"../Player"
var avail_maps: int = 3
var last_I: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_children()[0].name)
	pass

func next():
	Global.rooms_completed+=1
	var mapI = randi_range(1, avail_maps)
	print("%d -> mapI, %d -> last_I" % [mapI, last_I])
	if mapI == last_I:
		next()
	last_I = mapI
	for i in get_children():
		remove_child(i)
	var m_to_load: String = "res://maps/map_%d.tscn" % mapI
	print(m_to_load)
	var scene: PackedScene = ResourceLoader.load(m_to_load)
	var s = scene.instantiate()
	add_child(s)
	player.global_position = s.get_child(0).global_position
