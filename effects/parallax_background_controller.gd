extends Node2D
class_name ParallaxBackgroundController

@export var scroll_speed = 100

var layers: Array[Parallax2D] = []

func _ready() -> void:
	layers.assign(get_children())

#
