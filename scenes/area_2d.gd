extends Area2D

@export var dialogue_manager: Node
@export var npc_name: String = "Maya"
@export var lines: Array = ["Hello, welcome here!", "I'm Maya, the person in charge here. ", "You have been hired as the chef of our underground inn. ","You need to collect the raw materials for the dishes by yourself.","I will provide you with the menu.","Every time you successfully prepare a dish, we will grant you a skill. ","The first one is the Immortality Spell. ","When your health reaches zero, you will be teleported back to this cabin. ","Now go and get your menu from the table!"]
@export var label_default_text: String = "press Enter to talk" # 初始文字，编辑器面板可以修改

var player_in_range: bool = false

func _on_body_entered(body):

	if body.name == "Player":

		player_in_range = true
		var label = $"../Npc/Label"
		if label:
			label.text = label_default_text
			label.visible = true

func _on_body_exited(body):
	print("【离开】碰到物体：Player")
	if body.name == "Player":

		player_in_range = false
		var label = $"../Npc/Label"
		if label:

			label.text = label_default_text
			label.visible = false
		if dialogue_manager and dialogue_manager.is_dialog_open:
			dialogue_manager.close_dialogue()

func _process(delta):
	if dialogue_manager and dialogue_manager.is_dialog_open:
		return
	
	if player_in_range and Input.is_action_just_pressed("ui_accept"):

		if dialogue_manager:
			dialogue_manager.start_dialogue(npc_name, lines)
