extends Node

var player_pos
var room = {
	"complete": false,
	"enemies": 10
}

func init_room(enemies):
	room["complete"] = false
	room["enemies"] = enemies
