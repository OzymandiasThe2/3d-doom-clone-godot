extends KinematicBody
 
const MOVE_SPEED = 4
const MOUSE_SENS = 0.5

var damage = 100
var current_weapon = 1


onready var raycast = $Head/RayCast
onready var bullet = preload("res://Scenes/Gun/Bullet.tscn")
onready var muzzle = $Head/Camera/Muzzle

onready var gun1 = $Head/Hand/Gun1/Control
onready var anim_player = $Head/Hand/Gun1/AnimationPlayer
onready var anim_player_gun1 = $Head/Hand/Gun1/AnimationPlayer
onready var bullet1 = preload("res://Scenes/Gun/BulletSlow.tscn")

onready var gun2 = $Head/Hand/Gun2/Control
onready var anim_player_gun2 = $Head/Hand/Gun2/AnimationPlayer
onready var bullet2 = preload("res://Scenes/Gun/Bullet.tscn")

onready var gun3 = $Head/Hand/Gun3/Control
onready var anim_player_gun3 = $Head/Hand/Gun3/AnimationPlayer
onready var bullet3 = preload("res://Scenes/Gun/BulletBig.tscn")


func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	get_tree().call_group("Mob", "set_player", self)
 
 
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
 
func weapon_select():
	if Input.is_action_just_pressed("weapon_1"):
		current_weapon = 1
		anim_player = anim_player_gun1
		bullet = bullet2
		
		print("switching to revolver")
		
	elif Input.is_action_just_pressed("weapon_2"):
		current_weapon = 2
		anim_player = anim_player_gun2
		bullet = bullet1
		print("switching to pistol")
		
	elif Input.is_action_just_pressed("weapon_3"):
		current_weapon = 3
		anim_player = anim_player_gun3
		bullet = bullet3
		print("switching to shotgun")
	
	if current_weapon == 1:
		gun1.visible = true
	else:
		gun1.visible = false
	
	if current_weapon == 2:
		gun2.visible = true
	else:
		gun2.visible = false

	if current_weapon == 3:
		gun3.visible = true
	else:
		gun3.visible = false


func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		kill()
 
func _physics_process(delta):
	#print(Performance.get_monitor(Performance.TIME_FPS)) # Prints the FPS to the console
	weapon_select()
	
	
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec.z -= 1
	if Input.is_action_pressed("move_backwards"):
		move_vec.z += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_and_collide(move_vec * MOVE_SPEED * delta)
	if Input.is_action_pressed("shoot") and !anim_player.is_playing():
		anim_player.play("shoot")
		if raycast.is_colliding():
			#print("bullet is fired")
			var b = bullet.instance()
			muzzle.add_child(b)
			#print("bullet is made")
			b.look_at(raycast.get_collision_point(), Vector3.UP)
			b.shoot = true
			
		#var coll = raycast.get_collider()
		#if raycast.is_colliding() and coll.has_method("kill"):
		#	coll.kill()
 
func kill():
	get_tree().reload_current_scene()
