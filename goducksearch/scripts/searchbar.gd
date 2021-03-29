extends LineEdit

# variables
var url_head = "https://api.duckduckgo.com/?q="
var query = ""
var url_params = "&format=json&pretty=1"
var source_link = ""
var related = false

# nodes
onready var content_label = $contentLabel
onready var url_label = $urlButton

func _search_request():
	# get text from the LineEdit which this script is attached to
	query = get_text()
	
	# check to pick related results only
	if "!related" in query:
		related = true
		query = query.replace("!related", "")
	else: related = false
	
	# allows quitting from the search bar
	if query == "!exit" or query == "!quit":
		print ("quitting")
		get_tree().quit()
	elif query == "!clear":
		content_label.set_text("")
	# check if the search box is not empty
	elif query != "":
		# convert the query to the URL-friendly format
		query = query.percent_encode()
		# combine the url
		source_link = url_head + query + url_params
		$HTTPRequest.request(source_link)

# called when enter button is pressed while the searchbox is active
func _on_LineEdit_text_entered(new_text):
	_search_request()
	
# request search json result
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	# parse json
	var json = JSON.parse(body.get_string_from_utf8()).result
	#fill the information from json
	# if the summary result is available, use it
	if "Abstract" in json and json["Abstract"] != "" and not related:
		content_label.set_text("\"" + 
								json["Heading"] + "\"\n\n" + 
								json["Abstract"] + " (" + 
								json["AbstractSource"] + ")")
		source_link = json["AbstractURL"]
		url_label.set_text(source_link + "  (open in browser)")
	# if not, use 'related topics' queries
	elif json["RelatedTopics"].size() > 0:
		var topic_counts = (json["RelatedTopics"].size())
		content_label.set_text("")
		content_label.set_text("Results from DuckDuckGo:\n\n")
		
		for n in topic_counts:
			if "FirstURL" in json["RelatedTopics"][n]:
				content_label.set_text(content_label.get_text() + "[" + (n + 1) as String + "]" + " " + json["RelatedTopics"][n]["FirstURL"] + "\n" + json["RelatedTopics"][n]["Text"] +"\n\n\n")
			elif "Name" in json["RelatedTopics"][n]:
				for m in json["RelatedTopics"][n]["Topics"].size():
					content_label.set_text(content_label.get_text() + "[" + (m + 1) as String + "]" + " (" + json["RelatedTopics"][n]["Name"] + ") " + json["RelatedTopics"][n]["Topics"][m]["FirstURL"] + "\n" + json["RelatedTopics"][n]["Topics"][m]["Text"] +"\n\n\n")
		
		url_label.set_text(source_link + "  (open in browser)")
	# if nothing found, give up your life and cry
	else:
		content_label.set_text("The ducks were unable to find anything related to the query :(")
		url_label.set_text(source_link + "  (open in browser)")

# Search button pressed
func _on_Button_pressed():
	_search_request()

# URL button pressed
func _on_urlButton_pressed():
	if source_link != "":
		OS.shell_open(source_link)
