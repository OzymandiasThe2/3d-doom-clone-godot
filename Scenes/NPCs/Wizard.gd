extends KinematicBody
 
const MOVE_SPEED = 3
 
onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer
 
var player = null
var dead = false
 
func _ready():
	anim_player.play("shoot")
	add_to_group("zombies")
 
func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
 

	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()
 
 
func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")
 
func set_player(p):
	player = p
