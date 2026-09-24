extends GridMap

@export var enemies_to_start: int = 5
@onready var player_start: Marker3D = $PlayerStart
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(enemies_to_start, "+",(floor(Global.rooms_completed/2))," ", Global.rooms_completed)
	enemies_to_start+=(floor(Global.rooms_completed/2))
	
	Global.init_room(enemies_to_start)
	
	$Path3D/PathFollow3D/EnemySpawner.enemies = enemies_to_start
	print("loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.room["enemies"] <= 0:
		print("hooray!!! you win this room! selecting random one from available ones and switching to it...")
		Global.room["complete"] = true
		get_parent().next()
