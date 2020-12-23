extends RigidBody

var triggered = false
var damage = 125

onready var blast_radius = $BlastRadius
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Grenade_body_entered(body):
	if not triggered:
		timer.start()
		triggered = true

func _on_Timer_timeout():
	var bodies = blast_radius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Mob"):
			var space = get_world().direct_space_state
			var collision = space.intersect_ray(global_transform.origin, body.global_transform.origin)
			if collision.collider.is_in_group("Mob"):
				body.health -= damage
				print("Grenade has hit " + body.name + " Current hitpoints at: " + str(body.health))
		queue_free()
