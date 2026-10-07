extends Node
# 拾取物品完成信号，用来通知玩家刷新UI
signal item_picked()

# 各类物品全局计数器
var count_beef: int = 0
var flag = false

func pickup_item(item_type:String):
	match item_type:
		"beef":
			count_beef += 1

	emit_signal("item_picked")
