extends KinematicBody


onready var sprite = $Sprite3D
onready var label = $Sprite3D/StateGUI


func get_camera():
	var r = get_node('/root')
	return r.get_viewport().get_camera()

func position_label(label:Label, point3D:Vector3):
	var camera = get_camera()
	var cam_pos = camera.translation
	var offset = Vector2(label.get_size().x/2, 0)
	label.rect_position = camera.unproject_position(point3D) - offset



enum {
	IDLE,
	AGGRO,
	DEAD
}

var  array = [
	"IDLE",
	"AGGRO",
	"DEAD"
]


var state = IDLE
var target
var player = null
var dead = false
const TURN_SPEED = 2

onready var raycast = $RayCast
onready var ap = $AnimationPlayer
onready var eyes = $Eyes
onready var shoottimer = $ShootTimer

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return

func _ready():
	pass # Replace with function body.

func _on_SightRange_body_entered(body):
	if state == DEAD:
		pass
	elif body.is_in_group("Player"):
		state = AGGRO
		target = body
		shoottimer.start()
	

# warning-ignore:unused_argument
func _on_SightRange_body_exited(body):
	if body.is_in_group("Player"):
		print("Player has left aggro range")
		state = IDLE
		shoottimer.stop()
	elif state == DEAD:
		print("Mob is dead")
		pass
	#else:
	#	state = IDLE
	#	shoottimer.stop()
	

func _on_ShootTimer_timeout():
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			print("Hit")

func kill():
	state = DEAD
	
# warning-ignore:unused_argument
func _process(delta):
	var statepostion = int(state)
	label.text = str(array[statepostion])
	match state:
		IDLE:
			ap.play("idle")
		AGGRO:
			ap.play("shoot")
			rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))
		DEAD:
			dead = true
			$CollisionShape.disabled = true
			ap.play("die")
			#continue
	var cam = get_camera()
	var test_point:Vector3 = sprite.global_transform.origin
	if not cam.is_position_behind(test_point):
		if test_point.distance_to(cam.global_transform.origin) :
			position_label(label, test_point)





