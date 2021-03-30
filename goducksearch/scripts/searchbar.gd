extends LineEdit

# variables
var url_head = "https://api.duckduckgo.com/?q="
var query = ""
var url_params = "&format=json&pretty=1"
var source_link = ""
var related = false

# nodes
onready var content_label = $"/root/Control/contentLabel"
onready var url_label = $"/root/Control/urlButton"

func _ready():
	grab_focus()

func _search_request():
	# get text from the LineEdit which this script is attached to
	query = get_text()
	# check to pick related results only
	if "!related" in query:
		related = true
		query = query.replace("!related", "")
	else: related = false
	
	# allows quitting and clearing from the search bar
	if query == "!exit" or query == "!quit":
		print ("quitting")
		get_tree().quit()
	elif query == "!clear":
		content_label.set_text("")
	# check if the search box is not empty
	elif query != "":
		# sometimes the connection can be slow by OS, confusing user if this is working or not.
		# this is a way to inform user that the program is working when it is silently trying to connect to the internet.
		# I just don't know how to implement loading bar which would be more natural.
		content_label.set_text("Attempting to retrieve data . . .")
		# convert the query to the URL-friendly format
		query = query.percent_encode()
		# combine the url
		source_link = url_head + query + url_params
		$HTTPRequest.request(source_link)

func _print_results(json):
	# if the summary/"Abstract" result is available, or user doesn't prompt "!related", use this
	if "Abstract" in json and json["Abstract"] != "" and not related:
		# assigning the informations
		var topic_heading = json["Heading"]
		var topic_abstract = json["Abstract"]
		var abstract_source = json["AbstractSource"]
		var paragraph_format = "\"" + topic_heading + "\"\n\n" + topic_abstract + " (" + abstract_source + ")"
		# print the informations
		content_label.set_text(paragraph_format)
		source_link = json["AbstractURL"]
		url_label.set_text(source_link + "  (open in browser)")
	# if not, use 'related topics' queries. It's an array of results
	elif json["RelatedTopics"].size() > 0:
		var topic_counts = (json["RelatedTopics"].size())
		content_label.set_text("")
		content_label.set_text("Results from DuckDuckGo:\n\n")
		url_label.set_text(source_link + "  (open in browser)")
		# Exposing array of results from JSON
		for n in topic_counts:
			# check if the first array member "FirstURL" exists, then go that way
			if "FirstURL" in json["RelatedTopics"][n]:
				# assigning the informations
				var refered_url = json["RelatedTopics"][n]["FirstURL"]
				var text_content = json["RelatedTopics"][n]["Text"]
				var paragraph_format = "[" + (n + 1) as String + "]" + " " + refered_url + "\n" + text_content +"\n\n\n"
				# print the informations
				content_label.set_text(content_label.get_text() + paragraph_format)
			# There may be another array of results under specific topic inside the same array.
			# checks it by looking up if array member "Name" exist instead of "FirstURL"
			elif "Name" in json["RelatedTopics"][n]:
				# Array member "Topics" contains another arrays.
				for m in json["RelatedTopics"][n]["Topics"].size():
					# assigning informations
					var topic_name = json["RelatedTopics"][n]["Name"]
					var refered_url = json["RelatedTopics"][n]["Topics"][m]["FirstURL"]
					var text_content = json["RelatedTopics"][n]["Topics"][m]["Text"]
					var paragraph_format = "[" + String(n + 1) + "." + String(m + 1) + "]" + " (" + topic_name + ") " + refered_url + "\n" + text_content +"\n\n\n"
					# print the informations
					content_label.set_text(content_label.get_text() + paragraph_format)
		
	# if nothing found, give up your life and cry
	else:
		content_label.set_text("The ducks were unable to find anything related to the query :(")
		url_label.set_text(source_link + "  (open in browser)")

# called when enter button is pressed while the searchbox is active
func _on_LineEdit_text_entered(new_text):
	_search_request()
	
# request search json completed
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	# parse JSON
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	_print_results(json_result)
	
# Search button pressed
func _on_Button_pressed():
	_search_request()

# URL button pressed
func _on_urlButton_pressed():
	if source_link != "":
		print(source_link)
		OS.shell_open(source_link)
