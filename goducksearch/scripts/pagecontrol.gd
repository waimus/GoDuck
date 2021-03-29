extends Control

onready var popup_window = $WindowDialog

# This script controls the about window.
func _on_AboutButton_pressed():
	popup_window.set_title("About")
	popup_window.popup_centered()

func _on_close_pressed():
	popup_window.visible = false

func _on_source_pressed():
	OS.shell_open("https://github.com/waimus/GoDuck")

func _on_license_pressed():
	OS.shell_open("https://github.com/waimus/GoDuck/blob/main/LICENSE")
