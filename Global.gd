extends Node

var player_pos
var room = {
	"complete": false,
	"enemies": 10
}
enum powerups {
	FASTSHOOT,
	SPEED,
	LARGEBULLETS,
}
var rooms_completed: int = 0

func init_room(enemies):
	room["complete"] = false
	room["enemies"] = enemies
