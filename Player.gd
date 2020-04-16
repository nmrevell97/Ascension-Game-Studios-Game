extends KinematicBody2D
# Player. Our 2D sprite, Very Janky as of right now, but works. Kinda feels like Duct Tape Fixing
# Kinda Finished - 4/12/2020 READ TODO 
# TODO - 4/12/2020 NR
	#Organize and Documentation **Complete NR 4/12/2020**
	#Implement finish state for the attack finishing 
	#Smooth out controls
	#Transition to an animationtree (Bold of me to say, maybe have Nic look at it when he learns the engine)
#Constants 
const UP = Vector2(0, -1)
const GRAV = 20
const SPEED = 200
const J_Height = -550

var motion = Vector2() #Contains X and Y in single Variable
onready var Spriter = $AnimatedSprite #Initializes Sprite Animation spree
onready var Interact = $Interact/Hitbox #Initializes Hitbox for Interaction
onready var SwordSwing = $SwordSwing/Hitbox #Initializes Hitbox for Sword
onready var init_pos = position #Initalizes spawn position to be called for later
func _physics_process(delta): #Physics process
	motion.y += GRAV #Gravity is set up so player has gravity
	if Input.is_action_pressed("ui_right"): #Right movement
		motion.x = SPEED #Allows for the speed, show in SPEED constant
		Spriter.flip_h = false #Does not flip horizontal 
		Spriter.play("Run") #Runs Run Animation on Spriter (AnimatedSprite)
		Interact.disabled = true #Keeps animation Off until active
		$SwordSwing.rotation_degrees = 0 #Sets position of collision box
		$Interact.rotation_degrees = 0 #Sets position of collision box
		
	elif Input.is_action_pressed("ui_left"): #Left movement
		motion.x = -SPEED #Negative speed for left movement (-200)
		Spriter.flip_h = true #Flips horizontal sprite
		Spriter.play("Run") #Runs Run animation
		SwordSwing.disabled = true #Deactivates collision box
		Interact.disabled = true #Deactivates collsion box
		$SwordSwing.rotation_degrees = 180 #Flips collision box 180 degrees, allowing for player to attack
		$Interact.rotation_degrees = 180 #Flips collsion box 180 degrees, allowing player to interact
		
	elif Input.is_action_pressed("ui_Attack"): #Attack movement
		Spriter.play("Attack") #Plays attack movement
		SwordSwing.disabled = false #Enables attack collison
		
		Interact.disabled = true #Disables Interaction Collision
		motion.x = 0 #Sets motion to 0 when attacking. May need to rework this
		
	elif Input.is_action_pressed("ui_Interact"): #Allows for players in interact with certain NPCs - say a shop
		Interact.disabled = false #Activates interaction
		
	else:
		motion.x = 0 #Sets motion to 0
		Spriter.play("Idle") #Runs Idle Animation
		SwordSwing.disabled = true #Deactivates collisions
		Interact.disabled = true #Deactivates collisions
		
	if is_on_floor(): #If on floor
		if Input.is_action_just_pressed("ui_up"): #If jumping
			motion.y = J_Height #Jump Height activates
			
	else:
		Spriter.play("Jump") #Jump Height animation
	motion = move_and_slide(motion, UP) #Motion!
	
#Function that allows for the player to die
func kill():
	position = init_pos#Reset the position of the player
	pass

	#TODO As of 4/12/2020: Listed in priority
	#Organize/Document Code **COMPLETE** 4/12/2020 NR
	#Version Control through GitHub so I can get Nic on it **DUE DATE: 4/14/2020** **STATUS: COMPLETE**
	#Get Enemy AI working (Bold of me to say, I know)
		#Basic: Goomba
		#Advanced: Skeleton Archer (Projectiles!)
		#Mega-Advanced: Final boss
	#Tilemapping: Autotile prefferable
	#Level Design
		#Checkpoint System: Shouldn't be too hard implement
		#Interactable Objects: Coins, Chests, People
		#Go against the grain, Right -> Left (A more than D) 
	#Core Mechanics
		#Serialization: Save state, Load state
		#UI Mechanics (Player Health, Coins Collected, other stats(Monsters Slain Statistic? - Miniboss Challenge!))
		#UI Elements: Mainmenu, Pause state



func _on_SwordSwing_body_entered(body):
		if body.get_name() == "Enemy" or body.get_name() == "Enemy2": #If enemy decides to die
			body.queue_free()
