extends Node3D

var screen_size : Vector2i = Vector2i.ZERO

@onready var gaming_space : Control = get_node("GamingSpace")

func _ready():
	screen_size = get_viewport().size
	gaming_space.set_size(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
