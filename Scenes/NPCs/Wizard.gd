extends KinematicBody
 
var health = 420

onready var anim_player = $AnimationPlayer
 
var player = null
var dead = false
 
func _ready():
	anim_player.play("shoot")


func _process(delta):
	if health <= 0 and dead == false:
		kill()
		print(name + " has been killed")

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
 
func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")
 
