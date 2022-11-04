extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var path_1 = preload("res://working/level_pngs/mushvroom_0003_mainpath1.png")
var path_2 = preload("res://working/level_pngs/mushvroom_0002_mainpath2.png")
var path_3 = preload("res://working/level_pngs/mushvroom_0001_mainpath3.png")
var path_4 = preload("res://working/level_pngs/mushvroom_0000_mainpath4.png")
var path_5 = preload("res://working/level_pngs/mushvroom_0003_mainpath5.png")
var path_6 = preload("res://working/level_pngs/mushvroom_0000_mainpath6.png")
var path_debug = preload("res://working/level_pngs/debug_layout.png")


var paths = [path_1, path_2, path_3, path_4, path_5, path_6, path_debug]

onready var mainpath = $mainpath


# Called when the node enters the scene tree for the first time.
func _ready():
	change_path(5)
	pass # Replace with function body.

func change_path(index = -1):
	if index == -1:
		randomize()
		index = randi()%4
	mainpath.texture = paths[index]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
