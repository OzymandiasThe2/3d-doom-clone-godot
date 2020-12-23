extends RigidBody

var dropped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(delta):
	if dropped == true:
		apply_impulse(transform.basis.z, -transform.basis.z * 10)
		dropped = false
