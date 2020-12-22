extends Node

var battle_music  = load("res://Music/DoomMusic.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stream = battle_music
	$Music.play()
	$Music.volume_db = -30

