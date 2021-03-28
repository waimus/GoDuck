extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var urlHead = "https://api.duckduckgo.com/?q="
var urlParams = "&format=json"
var jsonPretty = "&pretty=1"

#onready var line_edit := $Control/LineEdit
onready var title_label = $titleLabel
onready var content_label = $contentLabel
onready var source_label = $sourceLabel
onready var url_label = $urlLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _search_request():
	var search_string = urlHead + get_text() + urlParams
	# title_label.set_text(get_text())
	if get_text() != "":
		$HTTPRequest.request(search_string)

func _on_LineEdit_text_entered(new_text):
	_search_request()
	
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8()).result
	print(json["Abstract"])
	
	title_label.set_text(json["Heading"])
	content_label.set_text(json["Abstract"])
	source_label.set_text(json["AbstractSource"])
	url_label.set_text(json["AbstractURL"])


func _on_Button_pressed():
	_search_request()
