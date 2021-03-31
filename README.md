# GoDuck
Quick and basic implementation of [DuckDuckGo *Instant Answer* API](https://duckduckgo.com/api) using Godot Engine and GDScript. This does not use the full search result from DuckDuckGo. In an okay-ish state at the moment.

## WHY?
Biggest question on earth about this project. Well I don't know, if it's not because I need to make a program for class project about "information", I wouldn't create a program related to search engine. Why would anyone make or even use a 'search engine desktop client' when the search engine works better on browser.

This is also my first "actual" project made with Godot Engine. I had a lot of fun styling the app with the available UI tools, it's great.

## Open in Godot
Using Godot Engine version 3.2.3 stable official (Steam). May work using other Godot versions.

* Use `git clone https://github.com/waimus/GoDuck.git` or download zip to get this project files.
* Open Godot project manager and open the import menu.
* Load the `project.godot` file in the `goducksearch` folder.

## Screenshots
#### GoDuck running on linux X11, HTML5, and HTML5 mobile
![screenshot](./images/goduck23.png)

## Downloads
* [Try this on your browser](https://waimus.github.io/goduckweb/)
* [Linux x86_64](https://github.com/waimus/GoDuck/releases/download/v2.1.0/goduck-2.1-29_march_2021-linux_x86-64.zip)
* [Windows](https://github.com/waimus/GoDuck/releases/download/v2.1.0/goduck-2.1-29_march_2021-windows.zip)

Check out the [release page](https://github.com/waimus/GoDuck/releases).

## Usage Guide
Type any keyword on the search bar and press enter or by clicking the "Instant Answer" button. GoDuck allows several commands which started with prefix `!`, those are:
* `!related`: Some search result may directly show a Wikipedia summary. Use `!related` next to your keyword to show DuckDuckGo results instead.
* `!clear`: Clear the content text.
* `!quit` and `!exit`: Quit GoDuck.

## License
* This project is licensed under the [MIT license](https://github.com/waimus/GoDuck/blob/main/LICENSE).

## Credits
* This project uses Fira Sans Book font ([SIL OPEN FONT LICENSE Version 1.1](https://github.com/bBoxType/FiraSans/blob/master/OFL.txt))
* This project may show Wikipedia content ([CC BY-SA 3.0](https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License))
* This project uses [DuckDuckGo Instant Answer API](https://duckduckgo.com/api)