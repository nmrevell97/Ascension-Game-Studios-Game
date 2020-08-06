extends KinematicBody2D

export var EnemySpeed = 20 #Enemy Speed initialized
var enMo = Vector2() #Motion declared
export var grav = 20 #gravity initialized
 
var enDir = 1 #Initial direction in which the enemy is facing on the x axis
var UP = Vector2(0,-1) #Var for keeping this dude grounded
var OppositeDir = -1 #opposite direction means -1 x

func _ready():
	set_physics_process(true) #Sets physics process equal to true ALWAYS
func _physics_process(delta):
	enMo.y += grav #Gravity enabled
	
	if is_on_wall() or $RayCast2D.is_colliding() ==  false: #if the enemy hits a wall or the raycast is NO LONGER colliding with the ground
		enDir = enDir * OppositeDir #Opposite direction!
		$RayCast2D.scale.x *= -1 #sets the new parameter for the raycast
	if enDir == 1: #if direction is equal to 1
		$AnimatedSprite.flip_h = false #do not flip sprite
		$RayCast2D.scale.x *= -1 #change raycast to look for -1
	elif enDir == -1: #if direction is equal to -1
		$AnimatedSprite.flip_h = true #flip sprite
		$RayCast2D.scale.x *= 1 #look for 1





	enMo.x = enDir * EnemySpeed
	enMo = move_and_slide(enMo, UP)
