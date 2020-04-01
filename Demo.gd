extends Control


var window_modes := {
	0: {
		description = "Fullscreen",
		fullscreen = true,
	},
	1: {
		description = "1920×1080 (HD)",
		fullscreen = false,
		window_size = Vector2(1920, 1080)
	},
	2: {
		description = "960×540 (HD, halved)",
		fullscreen = false,
		window_size = Vector2(960, 540)
	},
	3: {
		description = "845×548 (note: the 2nd Label now has 3 lines in 2d mode)",
		fullscreen = false,
		window_size = Vector2(845, 548)
	},
}
var current_window_mode := 0


func _ready():
	var popup:PopupMenu = $WindowSizes.get_popup()
	popup.connect("id_pressed", self, "_on_window_change_requested")
	popup.clear()
	for id in window_modes:
		popup.add_item(window_modes[id].description, id)


func _on_window_change_requested(id):
	OS.window_fullscreen = window_modes[id].fullscreen
	current_window_mode = id
	if id > 0:
		OS.window_size = window_modes[id].window_size


func _process(_delta):
	$CurrentWindowSize.text = str(OS.window_size)


func _on_CheckButton_toggled(button_pressed):
	get_node("/root").get_texture().flags = Texture.FLAG_FILTER if button_pressed else 0 # 0 is the "no filter" default value
