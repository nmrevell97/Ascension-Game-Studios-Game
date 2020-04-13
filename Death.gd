extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



func _on_Area2D_body_entered(body):
	if body.get_name() == "Player": #If player decides to die
		body.kill()

#TODO:
	#Create similar thing for enemies who oopsie into the wild yonder
