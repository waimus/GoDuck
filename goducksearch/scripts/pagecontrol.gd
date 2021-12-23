extends Control

onready var popup_window : WindowDialog = $WindowDialog

func _init() -> void:
	OS.min_window_size = Vector2(320, 480)

# This script controls the about window.
func _on_AboutButton_pressed() -> void:
	popup_window.set_title("About")
	popup_window.popup_centered()

func _on_close_pressed() -> void:
	popup_window.visible = false

func _on_source_pressed() -> void:
	OS.shell_open("https://github.com/waimus/GoDuck")

func _on_license_pressed() -> void:
	OS.shell_open("https://github.com/waimus/GoDuck/blob/main/LICENSE")

# This is for mobile HTML5 input workaround
func _on_TextureButton_pressed() -> void:
	var search_bar = $"panel-background/panel-topbar/searchBar"
	# if runs on Android or iOS or checks via touchscree support, prompt an input via JS
	if OS.get_name() == 'Android' or OS.get_name() == "iOS" or OS.has_touchscreen_ui_hint() and OS.has_feature('JavaScript'):
		search_bar.text = JavaScript.eval("""window.prompt('type anything to search')""")
	# if not on mobile, activate the searchbar instead.
	else: search_bar.grab_focus()
