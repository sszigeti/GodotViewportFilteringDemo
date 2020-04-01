# A quick Godot project to demonstrate the effects of font hinting, and the lack of filtering on the root Viewport

[Original Reddit post](https://www.reddit.com/r/godot/comments/fsw3n0/solved_i_finally_have_consistent_font_hinting_due/)

When you're not using a "pixel art" visual style, you must think of texture filtering because you have to support multiple resolutions.

Simply put, this usually means opening ProjectSettings, then going to "Display/Window" and switching "Stretch/Mode" to 2d. There's also a viewport option here (aside the disable option for the pixel art style). If you also enable fullscreen ("display/window/size/fullscreen"), then there's no difference between the rendered results, however if you allow windowed mode, then using viewport will render something horrible, because it doesn't use filtering at all.

An easy choice is to use 2d then, because at first glance this seems to take care of everything.

Except for the rendering of text (i.e. Labels and RichTextLabels), because of the concept of "font hinting". Hinting is a technique that aims to offer best legibility at small font sizes, and as a consequence the actual resolution will affect the rendered size (a.k.a. bounding box) of a text. In other words, a Label which prints "Hello, world" in a font size set to 18 pixels would require N pixels at fullscreen, but N+M on a different resolution. In practice, this could mean that if you have several small texts on your screen, then in windowed mode some of your Labels might require line breaks while those very same Labels would render just fine in a single row at fullscreen. Breaking consistency this way is best avoided.

Without going into too much technical details, disabling font hinting is probably never a good idea, so we're almost back at square one: we must support multiple screen resolutions, but screen resolution affects the quality of the rendered result.

All this headache, because the viewport window strech mode looks fugly in windowed mode... Only if there was a way to enable filtering on the magical root Viewport node...

I haven't been able to find such an option anywhere, so until it is added, this problem can be remedied by having a singleton that grabs the root Viewport node and switches texture filtering on. The best thing is that this is a "fire and forget" procedure that doesn't seem to have any side-effects and can be added to any Godot project easily.

Steps to enable root Viewport filtering:

(1) Create a script called "RootViewportFiltering.gd" with this content:

	extends Node
	func _enter_tree():
	    get_node("/root").get_texture().flags = Texture.FLAG_FILTER

(2) Add it as an Autoload.

(3) Make sure you use viewport as "Stretch mode"

(4) Enjoy!

All info here is public domain, can be used without any restrictions.