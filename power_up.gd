extends Area3D

class_name Powerup
signal collected

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
		#collected.emit()
		collected.emit()
		queue_free()
	elif body is not GridMap:
		print("hit body named ",body.name,", and other data: ", body)
		collected.emit()
		queue_free()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_area_entered(area: Area3D) -> void:
	print("hit by area")
	if area is Bullet:
		queue_free()
		collected.emit()
