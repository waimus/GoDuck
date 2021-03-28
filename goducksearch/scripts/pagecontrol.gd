extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var popup_window = $WindowDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AboutButton_pressed():
	popup_window.set_title("About")
	popup_window.popup_centered()

func _on_close_pressed():
	popup_window.visible = false

func _on_source_pressed():
	OS.shell_open("https://github.com/waimus")
