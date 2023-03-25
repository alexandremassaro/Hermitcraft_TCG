extends Node2D


@onready var gaming_field : Control = get_node("GameField")

func _ready():
	_set_screen_resize()


# This method resizes the base constrol node "GameField" everytime the screen is resized
func _set_screen_resize():
	var viewport = get_viewport()
	viewport.connect("size_changed", _on_viewport_size_changed)


# This method is called whenever the viewport emits the signal "size_changed"
func _on_viewport_size_changed():
	# Resizes the GameField node according to the biewport size
	gaming_field.set_size(get_viewport().size)

