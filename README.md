# Minimap Titles
[Atom](https://atom.io/) package to convert the selected text to ASCII art using [FIGlet](http://www.figlet.org/) and then comment it.

The chosen figlet font (ANSI Shadow) is perfect for minimap visualization. Commenting supports several file extensions:
- js
- sh, bash
- yml, yaml
- css, scss, sass
- coffee
- html
- md
- php
- vb
- njk
- py
- tex, cls
- sql

Files with no extension will be treated as Shell scripts.

Select some text to convert something like this:

```
hello world
```

into something like this:

```
# ██   ██ ███████ ██      ██       ██████      ██     ██  ██████  ██████  ██      ██████  
# ██   ██ ██      ██      ██      ██    ██     ██     ██ ██    ██ ██   ██ ██      ██   ██
# ███████ █████   ██      ██      ██    ██     ██  █  ██ ██    ██ ██████  ██      ██   ██
# ██   ██ ██      ██      ██      ██    ██     ██ ███ ██ ██    ██ ██   ██ ██      ██   ██
# ██   ██ ███████ ███████ ███████  ██████       ███ ███   ██████  ██   ██ ███████ ██████
```

you can also `Toggle Comment Borders` to put a border around the text to add more distinction in the minimap:

```
###############################################################################
# ██   ██ ███████ ██      ██       ██████      ██     ██  ██████  ██████  ██      ██████
# ██   ██ ██      ██      ██      ██    ██     ██     ██ ██    ██ ██   ██ ██      ██   ██
# ███████ █████   ██      ██      ██    ██     ██  █  ██ ██    ██ ██████  ██      ██   ██
# ██   ██ ██      ██      ██      ██    ██     ██ ███ ██ ██    ██ ██   ██ ██      ██   ██
# ██   ██ ███████ ███████ ███████  ██████       ███ ███   ██████  ██   ██ ███████ ██████
###############################################################################
```

Note that `Toggle Comment Borders` determines border size based on your editors preferred line length, Atom's default is 80 as shown above.

The difference is slight and completely based on user preference:

<img src="http://i.imgur.com/xBCmrSx.png" alt="Border vs. No Border Example">

## Usage
To convert text, select the text you wish to convert, and do **any** of the following:
- Press `ctrl-shift-del` **or**
- Select `Minimap Titles: Convert` in the [command palette](https://atom.io/docs/latest/getting-started-atom-basics#command-palette) **or**
- Select _Packages_ -> _Minimap Titles_ -> _Convert_ from the main menu **or**
- Right click on the selected text, and select _Minimap Titles: Convert_ from the context menu

To create comment borders around text to help distinguish sections in the minimap do the following:
- Select _Packages_ -> _Minimap Titles_ -> _Toggle Comment Borders_ from the main menu
- Run the Convert command on your text as detailed above

To set a custom font, set `atom-minimap-titles.font` in your atom config file, as such:
```
"atom-minimap-titles":
  font: "Colossal"
```
See existing fonts in the [figlet font database](http://www.figlet.org/fontdb.cgi).

## Credits
Based on the following packages:
- [atom-figletify](https://github.com/robatron/atom-figletify)
- [block-comment](https://github.com/RayKwon/atom-block-comment/)
