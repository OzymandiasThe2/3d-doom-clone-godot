extends RigidBody

var shoot = false


const DAMAGE = 25
const SPEED = 10 

onready var sprite = $Sprite3D
onready var label = $Sprite3D/Label


func get_camera():
	var r = get_node('/root')
	return r.get_viewport().get_camera()

func position_label(label:Label, point3D:Vector3):
	var camera = get_camera()
	var cam_pos = camera.translation
	var offset = Vector2(label.get_size().x/2, 0)
	label.rect_position = camera.unproject_position(point3D) - offset

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)

# warning-ignore:unused_argument
func _physics_process(delta):
	if shoot:
		apply_impulse(transform.basis.z, - transform.basis.z * SPEED)
		

func _on_Area_body_entered(body):
	if body.is_in_group("Mob"):
		body.health -= DAMAGE
		label.text = str(DAMAGE)
		queue_free()
		var cam = get_camera()
		var test_point:Vector3 = sprite.global_transform.origin
		if not cam.is_position_behind(test_point):
		#	if test_point.distance_to(cam.global_transform.origin) :
				position_label(label, test_point)
		print("Bullet has hit enemy, Current hitpoints at: " + str(body.health))
	else:
		queue_free()
		
		
