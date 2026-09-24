extends Area3D

class_name Powerup


var type: Global.powerups = randi_range(0, Global.powerups.size() - 1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$Label3D.text = Global.powerups.keys()[type]
	print("'type' is ", Global.powerups.keys()[type], "!")
	pass # Replace with function body.

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.pUp(type)
		print("collected")
	queue_free()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
