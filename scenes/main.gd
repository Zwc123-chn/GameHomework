extends Node
signal item_picked()

var count_beef: int = 0
var flag = false

func pickup_item(item_type:String):
	match item_type:
		"beef":
			count_beef += 1

	emit_signal("item_picked")
